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
	
	public class Diagonals implements IPieceRule
	{
		private var _name:String;
		
		public function Diagonals(pieceName:String = "Bishop")
		{
			_name = pieceName;
		}
		
		public function execute(bitBoards:Array):void
		{
			var squares:Array = BoardUtil.getTrueSquares(bitBoards[_name + BitBoardTypes.S]);
			var color:String;
			var attacks:Object;
			var move:Array;

			for each(var square:String in squares)
			{
				color = (BoardUtil.isTrue(square, bitBoards[ChessPieces.WHITE + BitBoardTypes.S])) ? ChessPieces.WHITE : ChessPieces.BLACK;
				attacks = findAttacks(square, color, bitBoards);
				move = BitOper.and(attacks.piece, BitOper.not(BitOper.and(attacks.piece, bitBoards[color + BitBoardTypes.S])));
				bitBoards[color  + BitBoardTypes.ATTACK] = bitBoards[color  + BitBoardTypes.ATTACK] ? BitOper.or(bitBoards[color + BitBoardTypes.ATTACK], attacks.piece) : attacks.piece;
				bitBoards[square + BitBoardTypes.ATTACK] = bitBoards[square + BitBoardTypes.ATTACK] ? BitOper.or(bitBoards[square + BitBoardTypes.ATTACK], attacks.piece) : attacks.piece;
				bitBoards[color  + BitBoardTypes.XRAY] = bitBoards[color  + BitBoardTypes.ATTACK] ? BitOper.or(bitBoards[color + BitBoardTypes.ATTACK], attacks.xray) : attacks.xray;
				bitBoards[square + BitBoardTypes.XRAY] = bitBoards[square + BitBoardTypes.ATTACK] ? BitOper.or(bitBoards[square + BitBoardTypes.ATTACK], attacks.xray) : attacks.xray;
				bitBoards[square + BitBoardTypes.MOVE] = bitBoards[square + BitBoardTypes.MOVE] ? BitOper.or(bitBoards[square + BitBoardTypes.MOVE], move) : move;
				bitBoards[color + BitBoardTypes.MOVE] = bitBoards[color + BitBoardTypes.MOVE] ? BitOper.or(bitBoards[color + BitBoardTypes.MOVE], move) : move;
			}
		}
		
		private function findAttacks(square:String, color:String, bitBoards:Array):Object
		{
			var attack:BitBoard = new BitBoard();
			var xray:BitBoard = new BitBoard();
			var oppositeColor:String = (color == ChessPieces.WHITE) ? ChessPieces.BLACK : ChessPieces.WHITE;
			var start:Point = BoardUtil.squareToArrayNote(square);
			//Go left and up
			var i:int = 0;
			var j:int = start.x + 1;
			var stop:Boolean;
			for(i = start.y - 1; i >= 0; i--)
			{			
				if(j > 7)break;
				if(!stop){
					attack[j][i] = 1;
					if(bitBoards[BitBoardTypes.ALL_PIECES][j][i])
						stop = true;	
				}
				xray[j][i] = 1;
				j++;
			}
			//Go right and up
			j = start.x + 1;
			stop = false;
			for(i = start.y + 1; i < 8; i++)
			{
				if(j > 7)break;
				if(!stop){
					attack[j][i] = 1;
					if(bitBoards[BitBoardTypes.ALL_PIECES][j][i]) 
						stop = true;
				}
				xray[j][i] = 1;
				j++;
			}
			//Go left and down
			j = start.x - 1;
			stop = false;
			for(i = start.y - 1; i >= 0; i--)
			{			
				if(j < 0)break;
				if(!stop){
					attack[j][i] = 1;
					if(bitBoards[BitBoardTypes.ALL_PIECES][j][i]) 
						stop = true;
				}
				xray[j][i] = 1;
				j--;
			}
			//Go right and down
			j = start.x - 1;
			stop = false;
			for(i = start.y + 1; i < 8; i++)
			{				
				if(j < 0)break;
				if(!stop){
					attack[j][i] = 1;
					if(bitBoards[BitBoardTypes.ALL_PIECES][j][i])
						stop = true;
				}
				xray[j][i] = 1;
				j--;
			}
			return {piece:attack, xray:xray};
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}