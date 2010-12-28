package org.osas3cf.validation
{
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.data.BitBoardMetaData;
	import org.osas3cf.data.BitBoardTypes;
	import org.osas3cf.data.MoveMetaData;
	import org.osas3cf.data.MoveVO;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.BoardUtil;
	import org.osas3cf.utility.Debug;
	
	public class EndGame extends Client
	{
		public static const NAME:String = "EndGame";
		
		private var bitBoards:Array;
		private var currentTurn:String;
		private var opponent:String;
		
		public function EndGame(){}
		
		override public function onMetaData(metaData:MetaData):void
		{
			switch(metaData.type)
			{
				case MetaData.CLIENT_ADDED:
					var client:ClientVO = metaData.data as ClientVO;
					if(client is EndGame)
					{
						//setup class
					}
					break;
				case BitBoardMetaData.UPDATED:
					bitBoards = metaData.data as Array;
					//see if the bitboard has check, checkmate or stalemate
					findCheckMate();
					break;
				case MoveMetaData.MOVE_PIECE:
					var move:MoveVO = metaData.data as MoveVO
					currentTurn = move.piece.indexOf(ChessPieces.WHITE) == -1 ? ChessPieces.WHITE : ChessPieces.BLACK;
					opponent = currentTurn == ChessPieces.WHITE ? ChessPieces.BLACK : ChessPieces.WHITE;
					break;
			}
		}
		
		private function findCheckMate():void
		{
			var kingSquare:String = BoardUtil.getTrueSquares(BitOper.and(bitBoards[BitBoardTypes.KINGS], bitBoards[currentTurn + BitBoardTypes.S]))[0];
			if(BoardUtil.isTrue(kingSquare, bitBoards[opponent + BitBoardTypes.ATTACK]))
			{
				CONFIG::debug{Debug.out(currentTurn + " king in check", this)}
				if(BitOper.sum(bitBoards[kingSquare + BitBoardTypes.MOVE]) == 0)
				{
					CONFIG::debug{Debug.out("King cannot move out of check", this)}
					var opponentSquares:Array = BoardUtil.getTrueSquares(bitBoards[opponent + BitBoardTypes.S]);
					var attackingSquare:String;
					for each(var square:String in opponentSquares)
					{
						if(BoardUtil.isTrue(kingSquare, bitBoards[square + BitBoardTypes.ATTACK]))
						{
							if(attackingSquare){
								CONFIG::debug{Debug.out("Two or more pieces attacking the king", this)};
								sendMetaData(new MoveMetaData(MoveMetaData.CHECKMATE));
								return;	
							}else{
								attackingSquare = square;
							}
						}
					}
					if(BoardUtil.isTrue(attackingSquare, bitBoards[currentTurn + BitBoardTypes.ATTACK])){
						CONFIG::debug{Debug.out("Can capture attacking piece", this)};
						sendMetaData(new MoveMetaData(MoveMetaData.CHECK));
						return;
					}else{
						CONFIG::debug{Debug.out("Cannot capture attacking piece", this)};
						var attackSquares:Array = BoardUtil.getTrueSquares(bitBoards[attackingSquare + BitBoardTypes.ATTACK]);
						for each(var attackSquare:String in attackSquares)
						{
							if(BoardUtil.isTrue(attackSquare, bitBoards[currentTurn + BitBoardTypes.MOVE]))
							{
								CONFIG::debug{Debug.out("Can block check", this)}
								sendMetaData(new MoveMetaData(MoveMetaData.CHECK));
								return;
							}else{
								CONFIG::debug{Debug.out("Cannot block check", this)}
								sendMetaData(new MoveMetaData(MoveMetaData.CHECKMATE));
								return;
							}
						}
					}
				}else{
					CONFIG::debug{Debug.out("King can move out of check", this)}
					sendMetaData(new MoveMetaData(MoveMetaData.CHECK));
					return;
				}
			}
		}
		
		override public function get name():String{return NAME;}
	}
}