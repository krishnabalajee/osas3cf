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
	
	import org.osas3cf.board.Board;
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.board.Pieces;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.BitBoardTypes;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.BoardUtil;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.rules.IPieceRule;
	
	public class KingRule implements IPieceRule
	{
		private var _name:String;
		
		public function KingRule(pieceName:String = "King")
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
			var oppositeColor:String = (color == ChessPieces.WHITE) ? ChessPieces.BLACK : ChessPieces.WHITE;
			
			//Find the move pattern of opposite King with out square validation.
			var blackKing:Array = BitOper.and(bitBoards[oppositeColor + BitBoardTypes.S], bitBoards[name + BitBoardTypes.S]);
			var oppositeSquare:String = BoardUtil.getTrueSquares(blackKing)[0];
			var oppositeKingBitBoard:BitBoard = createMoveBitBoard(oppositeSquare);
			
			//Find all valid squares
			//1. Free spaces and opponents pieces
			var validSquares:Array = BitOper.or(bitBoards[oppositeColor + BitBoardTypes.S], BitOper.not(bitBoards[BitBoardTypes.BOARD]));
			//2. Cannot be next to other king
			validSquares = BitOper.and(validSquares, BitOper.not(oppositeKingBitBoard));
			//3. Cannot move into check
			validSquares = BitOper.and(validSquares, BitOper.not(bitBoards[oppositeColor + BitBoardTypes.ATTACK]));
			
			//TODO:Add castling
			
			//Can move to all valid squares in the move pattern of a king
			var attack:BitBoard = new BitBoard(BitOper.and(validSquares, createMoveBitBoard(square)));
			return attack;
		}
		
		private function createMoveBitBoard(square:String):BitBoard
		{
			var move:BitBoard = new BitBoard();
			if(!square) return move; //TODO: Disptach a core error event here.
			var start:Point = BoardUtil.squareToArrayNote(square);
			
			//Go up 1
			if(start.x + 1 <= 7)
				move[start.x + 1][start.y] = 1
			//Go up right 1
			if(start.x + 1 <= 7 && start.y + 1 <= 7)
				move[start.x + 1][start.y + 1] = 1
			//Go right 1
			if(start.y + 1 <= 7)
				move[start.x][start.y + 1] = 1
			//Go down right 1
			if(start.x - 1 >= 0 && start.y + 1 <= 7)
				move[start.x - 1][start.y + 1] = 1
			//Go down 1
			if(start.x - 1 >= 0)
				move[start.x - 1][start.y] = 1
			//Go down left 1
			if(start.x - 1 >= 0 && start.y - 1 >= 0)
				move[start.x - 1][start.y - 1] = 1
			//Go left 1
			if(start.y - 1 >= 0)
				move[start.x][start.y - 1] = 1
			//Go up left 1
			if(start.y + 1 <= 7 && start.y - 1 >= 0)		
				move[start.x + 1][start.y - 1] = 1	
			return move;
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}