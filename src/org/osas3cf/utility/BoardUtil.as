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
package org.osas3cf.utility
{
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	
	import org.osas3cf.data.BitBoard;
	
	public class BoardUtil
	{
		public function BoardUtil()
		{
			throw new IllegalOperationError("BoardUtil class should never be initalized as there are no BoardUtil objects in OSAS3CF");
		}
		
		public static function squareToArrayNote(square:String):Point
		{
			return new Point(Number(square.charAt(1)) - 1, Number(square.charCodeAt(0) - String("A").charCodeAt(0)));
		}
		
		public static function arrayNoteToSquare(point:Point):String
		{
			return String.fromCharCode(point.y + String("A").charCodeAt(0)) + String(point.x + 1);
		}
		
		public static function isTrue(square:String, bitBoard:Array):Boolean
		{
			var point:Point = BoardUtil.squareToArrayNote(square);
			if(String(bitBoard[point.x][point.y]) != "0")
				return true;
			else
				return false;
		}
		
		public static function getTrueSquares(board:Array):Array
		{
			var results:Array = [];
			for(var x:String in board)
			{
				for(var y:String in board[x])
				{
					if(String(board[x][y]) != "0")
					{
						results.push(BoardUtil.arrayNoteToSquare(new Point(Number(x), Number(y))));
					}
				}
			}
			return results;
		}
		
		public static function getLine(start:String, finish:String):Array
		{
			var result:BitBoard = new BitBoard();
			var iterFile:int = 0;
			if(finish.charCodeAt(0) > start.charCodeAt(0))
				iterFile = 1;
			else if(finish.charCodeAt(0) < start.charCodeAt(0))
				iterFile = -1;
			var iterRank:int = 0;
			if(Number(finish.charAt(1)) > Number(start.charAt(1)))
				iterRank = 1;
			else if(Number(finish.charAt(1)) < Number(start.charAt(1)))
				iterRank = -1;
			var file:int =  Number((start.charCodeAt(0)) - String("A").charCodeAt(0))
			var rank:int = Number(start.charAt(1));			
			while(iterFile != 0 || iterRank != 0)
			{
				file += iterFile;
				rank += iterRank;
				if(rank <= 8 && rank >= 1 && file >= 0 && file <= 7)
					result[rank - 1][file] = 1;
				if(file == (finish.charCodeAt(0) - String("A").charCodeAt(0)))
					iterFile  = 0;
				if(rank == Number(finish.charAt(1)))
					iterRank = 0;
			}
			return result;	
		}
	}
}