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
	import org.osas3cf.board.Square;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.BitBoardTypes;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.BoardUtil;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.rules.IPieceRule;
	
	public class KingRule implements IPieceRule
	{
		private var _name:String;
		private var validSquares:Array;
		
		public function KingRule(pieceName:String = "King")
		{
			_name = pieceName;
		}
		
		public function execute(bitBoards:Array):void
		{
			var squares:Array = BoardUtil.getTrueSquares(bitBoards[name + BitBoardTypes.S]);
			var color:String;
			var attack:Array;
			var move:Array;
			for each(var square:String in squares)
			{
				color = (BoardUtil.isTrue(square, bitBoards[ChessPieces.WHITE + BitBoardTypes.S])) ? ChessPieces.WHITE : ChessPieces.BLACK;
				attack = findAttacks(square, color, bitBoards);
				move = findMoves(square, color, bitBoards, attack);
				bitBoards[color  + BitBoardTypes.ATTACK] = bitBoards[color  + BitBoardTypes.ATTACK] ? BitOper.or(bitBoards[color + BitBoardTypes.ATTACK], attack) : attack;
				bitBoards[square + BitBoardTypes.ATTACK] = bitBoards[square + BitBoardTypes.ATTACK] ? BitOper.or(bitBoards[square + BitBoardTypes.ATTACK], attack) : attack;
				bitBoards[square + BitBoardTypes.MOVE] = bitBoards[square + BitBoardTypes.MOVE] ? BitOper.or(bitBoards[square + BitBoardTypes.MOVE], move) : move;
				bitBoards[color + BitBoardTypes.MOVE] = bitBoards[color + BitBoardTypes.MOVE] ? BitOper.or(bitBoards[color + BitBoardTypes.MOVE], move) : move;
				validSquares = null;
			}
		}
		
		private function findAttacks(square:String, color:String, bitBoards:Array):Array
		{
			var oppositeColor:String = (color == ChessPieces.WHITE) ? ChessPieces.BLACK : ChessPieces.WHITE;
			//Find the move pattern of opposite King with out square validation.
			var oppositeKing:Array = BitOper.and(bitBoards[oppositeColor + BitBoardTypes.S], bitBoards[name + BitBoardTypes.S]);
			var oppositeSquare:String = BoardUtil.getTrueSquares(oppositeKing)[0];
			var oppositeKingBitBoard:BitBoard = createMoveBitBoard(oppositeSquare);
			//Find all valid squares
			//1. All spaces
			validSquares = BitOper.not(new BitBoard);
			//2. Cannot be next to other king
			validSquares = BitOper.and(validSquares, BitOper.not(oppositeKingBitBoard));
			//3. Cannot move into check
			validSquares = BitOper.and(validSquares, BitOper.not(bitBoards[oppositeColor + BitBoardTypes.ATTACK]));
			//4. Cannot move in the XRAY of an attacking square
			if(BoardUtil.isTrue(square, bitBoards[oppositeColor + BitBoardTypes.ATTACK]))
			{
				var xrayPieces:Array = BitOper.or(bitBoards[BitBoardTypes.ROOKS],BitOper.or(bitBoards[BitBoardTypes.BISHOPS],bitBoards[BitBoardTypes.QUEENS]));
				var opponentSquares:Array = BoardUtil.getTrueSquares(BitOper.and(bitBoards[oppositeColor + BitBoardTypes.S], xrayPieces));
				for each(var opponentSquare:String in opponentSquares)
				{
					if(BoardUtil.isTrue(square, bitBoards[opponentSquare + BitBoardTypes.ATTACK]))
					{
						//square is attacking king
						validSquares = BitOper.and(validSquares, BitOper.not(bitBoards[opponentSquare + BitBoardTypes.XRAY]));
					}
				}
			}
			//Can move to all valid squares in the move pattern of a king 
			return new BitBoard(BitOper.and(validSquares, createMoveBitBoard(square)));;
		}
		
		private function findMoves(square:String, color:String, bitBoards:Array, attacks:Array):Array
		{
			//Cannot move to a square with same color piece
			var move:Array = BitOper.and(attacks, BitOper.not(BitOper.and(attacks, bitBoards[color + BitBoardTypes.S])));
			//Add castling
			var rank:String = (color == ChessPieces.WHITE) ? "1" : "8"; 
			if(square == "E" + rank)
			{
				var rookSquares:Array = BoardUtil.getTrueSquares(BitOper.and(bitBoards[color + BitBoardTypes.S], bitBoards[ChessPieces.ROOK + BitBoardTypes.S]));
				for each(var rookSquare:String in rookSquares)
				{
					if(rookSquare.charAt(0) == "H" && rookSquare.charAt(1) == rank)
					{
						if(validSquares[Number(rank) - 1][6] && validSquares[Number(rank) - 1][5])
						{
							move[Number(rank) - 1][6] = 1; //G1 or G7
						}
					}
					if(rookSquare.charAt(0) == "A" && rookSquare.charAt(1) == rank)
					{	
						if(validSquares[Number(rank) - 1][2] && validSquares[Number(rank) - 1][3])
						{
							move[Number(rank) - 1][2] = 1; //C1 or C7
						}
					}
				}				
			}			
			return move;
		}
		
		private function createMoveBitBoard(square:String):BitBoard
		{
			var move:BitBoard = new BitBoard();
			if(!square) return move;
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
			if(start.x + 1 <= 7 && start.y - 1 >= 0)		
				move[start.x + 1][start.y - 1] = 1	
			return move;
		}
		
		public function get name():String{return _name;}
	}
}