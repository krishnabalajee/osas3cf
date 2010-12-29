/**
 * The MIT License
 * Copyright (c) 2010 Craig Simpson
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 **/
package org.osas3cf.validation
{
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.data.metadata.BitBoardMetaData;
	import org.osas3cf.data.ChessBitBoards;
	import org.osas3cf.data.metadata.MoveMetaData;
	import org.osas3cf.data.vo.MoveVO;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.BoardUtil;
	import org.osas3cf.utility.Debug;
	
	public class EndGame extends Client
	{
		public static const NAME:String = "EndGame";
		
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
					Debug.out("Calculating end game", this);
					var bitBoards:Array = metaData.data as Array;
					//see if the bitboard has a draw, stalemate, checkmate and then check
					if(!BitOper.sum(bitBoards[currentTurn + ChessBitBoards.MOVE]))
						sendMetaData(new MoveMetaData(MoveMetaData.STALEMATE));
					else if(BitOper.sum(bitBoards[ChessBitBoards.ALL_PIECES]) == 2)
						sendMetaData(new MoveMetaData(MoveMetaData.DRAW));
					else
						findCheckMate(bitBoards);
					break;
				case MoveMetaData.MOVE_PIECE:
					var move:MoveVO = metaData.data as MoveVO
					currentTurn = move.piece.indexOf(ChessPieces.WHITE) == -1 ? ChessPieces.WHITE : ChessPieces.BLACK;
					opponent = currentTurn == ChessPieces.WHITE ? ChessPieces.BLACK : ChessPieces.WHITE;
					break;
			}
		}
		
		private function findCheckMate(bitBoards:Array):void
		{
			var kingSquare:String = BoardUtil.getTrueSquares(BitOper.and(bitBoards[ChessBitBoards.KINGS], bitBoards[currentTurn + ChessBitBoards.S]))[0];
			if(BoardUtil.isTrue(kingSquare, bitBoards[opponent + ChessBitBoards.ATTACK]))
			{
				CONFIG::debug{Debug.out(currentTurn + " king in check", this)}
				if(BitOper.sum(bitBoards[kingSquare + ChessBitBoards.MOVE]) == 0)
				{
					CONFIG::debug{Debug.out("King cannot move out of check", this)}
					var opponentSquares:Array = BoardUtil.getTrueSquares(bitBoards[opponent + ChessBitBoards.S]);
					var attackingSquare:String;
					for each(var square:String in opponentSquares)
					{
						if(BoardUtil.isTrue(kingSquare, bitBoards[square + ChessBitBoards.ATTACK]))
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
					if(BoardUtil.isTrue(attackingSquare, bitBoards[currentTurn + ChessBitBoards.ATTACK])){
						CONFIG::debug{Debug.out("Can capture attacking piece", this)};
						sendMetaData(new MoveMetaData(MoveMetaData.CHECK));
						return;
					}else{
						CONFIG::debug{Debug.out("Cannot capture attacking piece", this)};
						var attackSquares:Array = BoardUtil.getTrueSquares(bitBoards[attackingSquare + ChessBitBoards.ATTACK]);
						for each(var attackSquare:String in attackSquares)
						{
							if(BoardUtil.isTrue(attackSquare, bitBoards[currentTurn + ChessBitBoards.MOVE]))
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