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
	
	public class KnightRule implements IPieceRule
	{
		private var _name:String;
		
		public function KnightRule(pieceName:String = "Knight")
		{
			_name = pieceName;
		}
		
		public function execute(bitBoards:Array):void
		{
			var squares:Array = BoardUtil.getTrueSquares(bitBoards[name + BitBoardTypes.S]);
			var color:String;
			var attack:Array;
			for each(var square:String in squares)
			{
				color = (BoardUtil.isTrue(square, bitBoards[ChessPieces.WHITE + BitBoardTypes.S])) ? ChessPieces.WHITE : ChessPieces.BLACK;
				attack = findAttacks(square, color, bitBoards);
				bitBoards[color  + BitBoardTypes.ATTACK] = bitBoards[color  + BitBoardTypes.ATTACK] ? BitOper.or(bitBoards[color + BitBoardTypes.ATTACK], attack) : attack;
				bitBoards[square + BitBoardTypes.ATTACK] = bitBoards[square + BitBoardTypes.ATTACK] ? BitOper.or(bitBoards[square + BitBoardTypes.ATTACK], attack) : attack;
				bitBoards[square + BitBoardTypes.MOVE] = bitBoards[square + BitBoardTypes.MOVE] ? BitOper.or(bitBoards[square + BitBoardTypes.MOVE], attack) : attack;
			}
		}
		
		private function findAttacks(square:String, color:String, bitBoards:Array):Array
		{
			var attack:BitBoard = new BitBoard();
			var oppositeColor:String = (color == ChessPieces.WHITE) ? ChessPieces.BLACK : ChessPieces.WHITE;
			var validSquares:Array = BitOper.or(bitBoards[oppositeColor + BitBoardTypes.S], BitOper.not(bitBoards[BitBoardTypes.BOARD]));
			var start:Point = BoardUtil.squareToArrayNote(square);
			if(start.x + 2 <= 7)
			{
				//up right L
				if(start.y + 1 <= 7)
					attack[start.x + 2][start.y + 1] = validSquares[start.x + 2][start.y + 1];
				//up left L
				if(start.y - 1 >= 0)
					attack[start.x + 2][start.y - 1] = validSquares[start.x + 2][start.y - 1];
			}
			if(start.x + 1 <= 7)
			{
				//right up L
				if(start.y + 2 <= 7)
					attack[start.x + 1][start.y + 2] = validSquares[start.x + 1][start.y + 2];
				//left up L
				if(start.y - 2 >= 0)
					attack[start.x + 1][start.y - 2] = validSquares[start.x + 1][start.y - 2];				
			}
			if(start.x - 1 >= 0)
			{
				//right down L
				if(start.y + 2 <= 7)
					attack[start.x - 1][start.y + 2] = validSquares[start.x - 1][start.y + 2];
				//left down L
				if(start.y - 2 >= 0)
					attack[start.x - 1][start.y - 2] = validSquares[start.x - 1][start.y - 2];
			}
			if(start.x - 2 >= 0)
			{
				//down right L
				if(start.y + 1 <= 7)
					attack[start.x - 2][start.y + 1] = validSquares[start.x - 2][start.y + 1];
				//down left L
				if(start.y - 1 >= 0)
					attack[start.x - 2][start.y - 1] = validSquares[start.x - 2][start.y - 1];				
			}
			return attack;			
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}