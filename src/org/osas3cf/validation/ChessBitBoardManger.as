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
		private var evaluatedBoards:Array;
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
						if(evaluatedBoards && state.newState.toString() == evaluatedBoards[BitBoardTypes.BOARD].toString())
							bitBoards = evaluatedBoards;
						else
							bitBoards = generator.execute(state.newState as BitBoard);
						sendMetaData(new BitBoardMetaData(BitBoardMetaData.UPDATED, bitBoards));
					}
					break;
				case BitBoardMetaData.EVALUATE:
					evaluatedBoards = generator.execute(metaData.data as BitBoard);
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