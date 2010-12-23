package org.osas3cf.validation
{
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.board.Pieces;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.core.data.StateVO;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.BitBoardMetaData;
	import org.osas3cf.data.BitBoardTypes;
	import org.osas3cf.data.BoardState;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.rules.chess.*;
	
	public class ChessBitBoardManger extends Client
	{
		public static const NAME:String = "ChessBitBoardManager";
		
		private var bitBoards:Array = [];
		private var generator:BitBoardGen;
		
		public function ChessBitBoardManger(){}
		
		override public function onMetaData(metaData:MetaData):void
		{
			switch(metaData.type)
			{
				case MetaData.CLIENT_ADDED:
					var clientVO:ClientVO = metaData.data as ClientVO;
					if(clientVO.client is ChessBitBoardManger)
					{
						var rules:Array = [];
						rules.push(new PawnRule());
						rules.push(new KnightRule());
						rules.push(new Diagonals());
						rules.push(new HorizontalVertical());
						rules.push(new QueenRule());
						rules.push(new KingRule()); //King must always be last
						
						var colors:Array = [ChessPieces.WHITE, ChessPieces.BLACK];
						generator = new BitBoardGen(rules, colors);					
					}
					break;
				case MetaData.STATE_CHANGE:
					var state:StateVO = metaData.data as StateVO;
					if(state.type == BoardState.PIECES)
					{
						Debug.out(state.newState);
						bitBoards = generator.execute(state.newState as BitBoard);
						sendMetaData(new BitBoardMetaData(BitBoardMetaData.UPDATED, bitBoards));
					}
					break;
				case BitBoardMetaData.EVALUATE:
					var evaluatedBoards:Array = generator.execute(metaData.data as BitBoard);
					sendMetaData(new BitBoardMetaData(BitBoardMetaData.EVALUATED, evaluatedBoards));
					break;
				case MetaData.CLEAN_UP:
					bitBoards = null;
					generator = null;
					break;				
			}
		}
		
		override public function get name():String{return NAME;}
	}
}