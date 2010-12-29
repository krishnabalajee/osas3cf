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
	import org.osas3cf.data.ChessBitBoards;
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
			var squares:Array = BoardUtil.getTrueSquares(bitBoards[name + ChessBitBoards.S]);
			var color:String;
			var attack:Array;
			var move:Array;
			for each(var square:String in squares)
			{
				color = (BoardUtil.isTrue(square, bitBoards[ChessPieces.WHITE + ChessBitBoards.S])) ? ChessPieces.WHITE : ChessPieces.BLACK;
				attack = findAttacks(square, color, bitBoards);
				move = BitOper.and(attack, BitOper.not(BitOper.and(attack, bitBoards[color + ChessBitBoards.S])));
				bitBoards[color  + ChessBitBoards.ATTACK] = bitBoards[color  + ChessBitBoards.ATTACK] ? BitOper.or(bitBoards[color + ChessBitBoards.ATTACK], attack) : attack;
				bitBoards[square + ChessBitBoards.ATTACK] = bitBoards[square + ChessBitBoards.ATTACK] ? BitOper.or(bitBoards[square + ChessBitBoards.ATTACK], attack) : attack;
				bitBoards[square + ChessBitBoards.MOVE] = bitBoards[square + ChessBitBoards.MOVE] ? BitOper.or(bitBoards[square + ChessBitBoards.MOVE], move) : move;
				bitBoards[color + ChessBitBoards.MOVE] = bitBoards[color + ChessBitBoards.MOVE] ? BitOper.or(bitBoards[color + ChessBitBoards.MOVE], move) : move;
			}
		}
		
		private function findAttacks(square:String, color:String, bitBoards:Array):Array
		{
			var attack:BitBoard = new BitBoard();
			var oppositeColor:String = (color == ChessPieces.WHITE) ? ChessPieces.BLACK : ChessPieces.WHITE;
			var start:Point = BoardUtil.squareToArrayNote(square);
			if(start.x + 2 <= 7)
			{
				//up right L
				if(start.y + 1 <= 7)
					attack[start.x + 2][start.y + 1] = 1;
				//up left L
				if(start.y - 1 >= 0)
					attack[start.x + 2][start.y - 1] = 1;
			}
			if(start.x + 1 <= 7)
			{
				//right up L
				if(start.y + 2 <= 7)
					attack[start.x + 1][start.y + 2] = 1;
				//left up L
				if(start.y - 2 >= 0)
					attack[start.x + 1][start.y - 2] = 1;				
			}
			if(start.x - 1 >= 0)
			{
				//right down L
				if(start.y + 2 <= 7)
					attack[start.x - 1][start.y + 2] = 1;
				//left down L
				if(start.y - 2 >= 0)
					attack[start.x - 1][start.y - 2] = 1;
			}
			if(start.x - 2 >= 0)
			{
				//down right L
				if(start.y + 1 <= 7)
					attack[start.x - 2][start.y + 1] = 1;
				//down left L
				if(start.y - 1 >= 0)
					attack[start.x - 2][start.y - 1] = 1;				
			}
			return attack;			
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}