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
	
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.metadata.MoveMetaData;
	import org.osas3cf.data.vo.BoardVO;
	import org.osas3cf.data.vo.MoveVO;
	import org.osas3cf.utility.BoardUtil;
	CONFIG::debug{import org.osas3cf.utility.Debug;}

	public class Pieces extends Client
	{		
		public static const EMPTY_SQUARE:String 	= "0";
		
		public static const NAME:String 			= "Pieces";
				
		private var _pieces:Array = [];
		private var _capturedPieces:Array = [];
		
		public function Pieces(){}
		
		override public function onMetaData(metaData:MetaData):void
		{	
			switch(metaData.type)
			{
				case MetaData.CLIENT_ADDED:
					var clientVO:ClientVO = metaData.data as ClientVO;
					if(clientVO.client is Pieces)
						createPiecesArray(clientVO.params['row'], clientVO.params['column']);
				break;
				case MoveMetaData.MOVE_PIECE:
					var oldState:Array = new BitBoard(pieces);
					var square:MoveVO = metaData.data as MoveVO;
					CONFIG::debug{Debug.out("Move "+square.piece+" from " + square.currentSquare +" to "+square.newSquare , this);}
					setSquare(square.currentSquare, EMPTY_SQUARE);
					setSquare(square.newSquare, square.piece);
					sendMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES, oldState, new BitBoard(pieces))));
					break;
				case MoveMetaData.CAPTURE_PIECE:
					if(_capturedPieces.length > 0)
						oldState = new Array(_capturedPieces.toString());
					else
						oldState = [];
					square = metaData.data as MoveVO;
					CONFIG::debug{Debug.out("Capture "+square.piece+" from " + square.currentSquare, this);}
					_capturedPieces.push(square.piece);
					sendMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.CAPTURED_PIECES, oldState, _capturedPieces)));
					break;
				case MoveMetaData.PROMOTE_PIECE:
					oldState = new BitBoard(pieces);
					square = metaData.data as MoveVO;
					CONFIG::debug{Debug.out("Promote "+square.piece+" from " + square.currentSquare, this);}
					setSquare(square.currentSquare, square.piece);
					sendMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES, oldState, new BitBoard(pieces))));
					break;
				case MetaData.CLEAN_UP:
					cleanUp();
					break;											
				default:
					
					break;
			}
		}		
		
		protected function getSquare(square:String):String
		{
			var point:Point = BoardUtil.squareToArrayNote(square);
			if(point.x > pieces.length || point.y > pieces[0].length) return "";
			return pieces[point.x][point.y] as String;
		}
		
		protected function setSquare(square:String, piece:String):void
		{
			if(!square || !piece)return;
			var point:Point = BoardUtil.squareToArrayNote(square);
			if(point.x > pieces.length || point.y > pieces[0].length)
			{
				CONFIG::debug{Debug.out("Could not set piece, out of bounds of board", this);}
				return;
			}
			_pieces[point.x][point.y] = piece;
		}

		private function createPiecesArray(row:int, column:int):void
		{
			_pieces = []; 
			_capturedPieces = [];
			var rowArray:Array;
			for(var i:int = 0; i < column; i++)
			{
				rowArray = [];
				for(var j:int = 0; j < row; j++)
				{
					rowArray.push(EMPTY_SQUARE);
				}
				_pieces[i] = rowArray;
			}
			CONFIG::debug{Debug.out(_pieces.length+"x"+_pieces[0].length + " piece array created" , this);}
		}
		
		private function cleanUp():void
		{
			CONFIG::debug{Debug.out("Cleanup", this);}
			_pieces = _capturedPieces = null;
		}		
		
		override public function get name():String{return Pieces.NAME;}
		protected function get pieces():Array{return _pieces;}
		protected function get capturedPieces():Array {return _capturedPieces;}
	}
}