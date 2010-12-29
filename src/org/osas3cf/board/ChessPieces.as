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
package org.osas3cf.board
{
	import flash.geom.Point;
	
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.vo.BoardVO;
	import org.osas3cf.utility.BoardUtil;
	
	CONFIG::debug{import org.osas3cf.utility.Debug;}
	
	public class ChessPieces extends Pieces
	{
		public static const KING:String 	= "King";
		public static const QUEEN:String 	= "Queen";
		public static const ROOK:String 	= "Rook";
		public static const BISHOP:String 	= "Bishop";
		public static const KNIGHT:String 	= "Knight";
		public static const PAWN:String 	= "Pawn";
		
		public static const WHITE:String 	= "White";
		public static const BLACK:String 	= "Black";
		
		public static const NAME:String 	= "ChessPieces";
		
		private var initalSetup:Array = [[WHITE+ROOK,WHITE+KNIGHT,WHITE+BISHOP,WHITE+QUEEN,WHITE+KING,WHITE+BISHOP,WHITE+KNIGHT,WHITE+ROOK],
										 [WHITE+PAWN,WHITE+PAWN,WHITE+PAWN,WHITE+PAWN,WHITE+PAWN,WHITE+PAWN,WHITE+PAWN,WHITE+PAWN],
										 [0,0,0,0,0,0,0,0],
										 [0,0,0,0,0,0,0,0],
										 [0,0,0,0,0,0,0,0],
										 [0,0,0,0,0,0,0,0],
										 [BLACK+PAWN,BLACK+PAWN,BLACK+PAWN,BLACK+PAWN,BLACK+PAWN,BLACK+PAWN,BLACK+PAWN,BLACK+PAWN],
										 [BLACK+ROOK,BLACK+KNIGHT,BLACK+BISHOP,BLACK+QUEEN,BLACK+KING,BLACK+BISHOP,BLACK+KNIGHT,BLACK+ROOK]];
		
		public function ChessPieces(){}
		
		override public function onMetaData(metaData:MetaData):void
		{
			super.onMetaData(metaData);
			
			switch(metaData.type)
			{
				case MetaData.CLIENT_ADDED:
					var clientVO:ClientVO = metaData.data as ClientVO;
					if(clientVO.client is ChessPieces)
						setupPieces(clientVO.params['setup']);
				break;
			}
		}
		
		private function setupPieces(pieces:Array = null):void
		{
			var oldPieces:BitBoard = new BitBoard(this.pieces);
			pieces = pieces ? pieces : initalSetup;
			for(var x:String in pieces)
			{
				for(var y:String in pieces[x])
				{
					setSquare(BoardUtil.arrayNoteToSquare(new Point(Number(x),Number(y))), String(pieces[x][y]));
				}
			}
			CONFIG::debug{Debug.out("Piece setup complete", this);}
			sendMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES, oldPieces,  new BitBoard(this.pieces))));
		}
		
		override public function get name():String{return ChessPieces.NAME;}
	}
}