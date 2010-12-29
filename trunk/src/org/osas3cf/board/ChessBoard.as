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
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.IBroadcaster;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.ChessBitBoardManger;
	import org.osas3cf.validation.EndGame;
	import org.osas3cf.validation.MoveValidator;

	CONFIG::debug{import org.osas3cf.utility.Debug;}
	
	public class ChessBoard extends Client implements IBroadcaster
	{	
		private var board:Broadcaster;
		private var _name:String;
		
		public function ChessBoard(name:String = "ChessBoard")
		{
			_name = name;
			board = new Broadcaster(name);
		}
		
		override public function onMetaData(metaData:MetaData):void
		{
			switch(metaData.type)
			{
				case MetaData.CLIENT_ADDED:
					var clientVO:ClientVO = metaData.data as ClientVO;
					if(clientVO.client is ChessBoard)
					{
						var pieces:Array = clientVO.params.hasOwnProperty("setup") ? clientVO.params['setup'] : null;
						Debug.out("Creating ChessBoard : " + pieces);
						setUp(pieces);
					}
					break;	
				case MetaData.CLEAN_UP:
					cleanUp();
					break;
			}
		}
		
		public function addMetaData(metaData:MetaData):void
		{
			board.addMetaData(metaData);
		}		
		
		private function setUp(piecePostion:Array = null):void
		{
			CONFIG::debug{Debug.out("Setting up chess board", this);}
			var board:Object = {row:8, column:8};
			board.setup = piecePostion;
			addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(new EndGame())));
			addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(new MoveValidator())));
			addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(new ChessPieces(), board)));
		}
			
		private function cleanUp():void
		{
			CONFIG::debug{Debug.out("Cleaning up chess board", this);}
			addMetaData(new MetaData(MetaData.CLEAN_UP));
			board = null;
		}
		
		override public function get name():String{return _name;}
	}
}