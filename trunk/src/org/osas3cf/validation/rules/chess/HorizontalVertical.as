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
package org.osas3cf.validation.rules.chess
{
	import flash.geom.Point;
	
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.board.Pieces;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.BitBoardTypes;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.BoardUtil;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.rules.IPieceRule;
	
	public class HorizontalVertical implements IPieceRule
	{
		private var _name:String;
		
		public function HorizontalVertical(pieceName:String = "Rook")
		{
			_name = pieceName;
		}
		
		public function execute(bitBoards:Array):void
		{
			var squares:Array = BoardUtil.getTrueSquares(bitBoards[name + BitBoardTypes.S]);
			var color:String;
			
			for each(var square:String in squares)
			{
				color = (BoardUtil.isTrue(square, bitBoards[ChessPieces.WHITE + BitBoardTypes.S])) ? ChessPieces.WHITE : ChessPieces.BLACK;
				var attack:Array = findAttacks(square, color, bitBoards);
				if(bitBoards[square + BitBoardTypes.ATTACK]){
					bitBoards[square + BitBoardTypes.ATTACK] = BitOper.or(bitBoards[square + BitBoardTypes.ATTACK], attack);
					bitBoards[square + BitBoardTypes.MOVE] 	 = BitOper.or(bitBoards[square + BitBoardTypes.MOVE], attack);
				}else{
					bitBoards[square + BitBoardTypes.ATTACK] = bitBoards[square + BitBoardTypes.MOVE] = attack;
				}
				if(bitBoards[color + BitBoardTypes.ATTACK])
					bitBoards[color + BitBoardTypes.ATTACK] = BitOper.or(bitBoards[color + BitBoardTypes.ATTACK], attack);
				else
					bitBoards[color + BitBoardTypes.ATTACK] = attack;
			}
		}
		
		private function findAttacks(square:String, color:String, bitBoards:Array):Array
		{
			var attack:BitBoard = new BitBoard();
			var oppositeColor:String = (color == ChessPieces.WHITE) ? ChessPieces.BLACK : ChessPieces.WHITE;
			var validSquares:Array = BitOper.or(bitBoards[oppositeColor + BitBoardTypes.S], BitOper.not(bitBoards[BitBoardTypes.BOARD]));
			var start:Point = BoardUtil.squareToArrayNote(square);
			
			//Go left
			var i:int = 0;
			for(i = start.y - 1; i >= 0; i--)
			{
				if(validSquares[start.x][i] != Pieces.EMPTY_SQUARE){
					attack[start.x][i] = 1;
					if(bitBoards[oppositeColor + BitBoardTypes.S][start.x][i] == 1) break;
				}else{
					break;
				}
			}
			//Go right
			for(i = start.y + 1; i < 8; i++)
			{
				if(validSquares[start.x][i] != Pieces.EMPTY_SQUARE){
					attack[start.x][i] = 1;
					if(bitBoards[oppositeColor + BitBoardTypes.S][start.x][i] == 1) break;
				}else{
					break;
				}
			}			
			//Go up
			for(i = start.x + 1; i < 8; i++)
			{
				if(validSquares[i][start.y] != Pieces.EMPTY_SQUARE){
					attack[i][start.y] = 1;
					if(bitBoards[oppositeColor + BitBoardTypes.S][i][start.y] == 1) break;
				}else{
					break;
				}
			}			
			//Go down
			for(i = start.x - 1; i >= 0; i--)
			{
				if(validSquares[i][start.y] != Pieces.EMPTY_SQUARE){
					attack[i][start.y] = 1;
					if(bitBoards[oppositeColor + BitBoardTypes.S][i][start.y] == 1) break;
				}else{
					break;
				}
			}
			return attack;
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}