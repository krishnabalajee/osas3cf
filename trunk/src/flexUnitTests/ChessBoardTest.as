package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.board.ChessBoard;
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.core.data.StateVO;
	
	public class ChessBoardTest extends TestingBitBoards
	{		
		private var chessBoard:ChessBoard;
		private var debugClient:DebugClient;
		private var broadcaster:Broadcaster;
		
		[Before]
		public function setUp():void
		{
			broadcaster = new Broadcaster("DebugBroadCaster");
			chessBoard = new ChessBoard();
			debugClient = new DebugClient();
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(debugClient)));
			
		}
		
		[After]
		public function tearDown():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			chessBoard = null;
			debugClient = null;
		}
		
		[Test]
		public function testChessBoard():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(chessBoard)));
			Assert.assertTrue(debugClient.getMetaDataType(MetaData.ADD_CLIENT));
			var name:String = debugClient.getMetaDataType(MetaData.ADD_CLIENT).data.client.name;
			Assert.assertEquals(name, "ChessBoard");
		}
		
		[Test]
		public function testBoardSetup():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(chessBoard, {setup: rookBoard})));
			//Assert.assertTrue(debugClient.getMetaDataType(MetaData.STATE_CHANGE));
			//var state:StateVO = debugClient.getMetaDataType(MetaData.STATE_CHANGE).data as StateVO;
			//Assert.assertEquals(rookBoard.toString(), state.newState.toString());		
		}
	}
}