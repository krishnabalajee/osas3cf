package org.osas3cf.board
{
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.IBroadcaster;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.validation.ChessBitBoardManger;
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