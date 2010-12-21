package org.osas3cf.board
{
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.IBroadcaster;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;

	CONFIG::debug{import org.osas3cf.utility.Debug;}
	
	public class ChessBoard extends Client implements IBroadcaster
	{	
		private var board:Broadcaster;
		private var _name:String;
		
		public function ChessBoard(name:String = "ChessBoard")
		{
			_name = name;
			board = new Broadcaster(name);
			CONFIG::debug{Debug.out("ChessBoard created", this);}	
		}
		
		override public function onMetaData(metaData:MetaData):void
		{
			CONFIG::debug{Debug.out("onMetaData " + metaData, this);}
		}
		
		public function setUp(piecePostion:Array = null):void
		{
			var board:Object = {row:8, column:8};
			board.setup = piecePostion;
			addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(new ChessPieces(), board)));
		}
			
		public function cleanUp():void
		{
			addMetaData(new MetaData(MetaData.CLEAN_UP));
			board = null;
		}
		
		public function addMetaData(metaData:MetaData):void
		{
			board.addMetaData(metaData);
		}
		
		override public function get name():String
		{
			return _name;
		}
	}
}