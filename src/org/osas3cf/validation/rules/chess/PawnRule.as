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
	
	public class PawnRule implements IPieceRule
	{
		private var _name:String;
		
		public function PawnRule(pieceName:String = "Pawn")
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
				var move:Array = findMoves(square, color, bitBoards);
				bitBoards[square + BitBoardTypes.MOVE] = bitBoards[square + BitBoardTypes.MOVE] ? BitOper.or(bitBoards[square + BitBoardTypes.MOVE], move) : move;
				bitBoards[color + BitBoardTypes.MOVE] = bitBoards[color + BitBoardTypes.MOVE] ? BitOper.or(bitBoards[color + BitBoardTypes.MOVE], move) : move;
			}
		}
		
		private function findAttacks(square:String, color:String, bitBoards:Array):Array
		{
			var attack:BitBoard = new BitBoard();
			var start:Point = BoardUtil.squareToArrayNote(square);
			var up:int = (color == ChessPieces.WHITE) ? 1 : -1;
			if(start.x + up >= 0 && start.x + up <= 7)
			{
				//up left
				if(start.y - 1 >= 0)
					attack[start.x + up][start.y - 1] = 1;
				//up right
				if(start.y + 1 <= 7)
					attack[start.x + up][start.y + 1] = 1;			
			}
			return attack;			
		}
		
		private function findMoves(square:String, color:String, bitBoards:Array):Array
		{
			var oppositeColor:String = (color == ChessPieces.WHITE) ? ChessPieces.BLACK : ChessPieces.WHITE;
			var move:BitBoard = new BitBoard(BitOper.and(bitBoards[square + BitBoardTypes.ATTACK], bitBoards[oppositeColor + BitBoardTypes.S]));
			var validSquares:Array = BitOper.not(bitBoards[BitBoardTypes.BOARD]);
			var start:Point = BoardUtil.squareToArrayNote(square);
			var up:int = (color == ChessPieces.WHITE) ? 1 : -1;
			if(start.x + up >= 0 && start.x + up <= 7)
			{
				//up 1
				move[start.x + up][start.y] = validSquares[start.x + up][start.y];
				//up 2
				if((color == ChessPieces.WHITE && square.charAt(1) == "2") || (color == ChessPieces.BLACK && square.charAt(1) == "7"))
					move[start.x + up*2][start.y] = validSquares[start.x + up][start.y];			
			}
			//TODO: Add in en passant rule
			return move;			
		}
		
		public function get name():String{return _name;}
	}
}