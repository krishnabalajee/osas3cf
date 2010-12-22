package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.board.ChessBoard;
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	
	public class ChessBoardTest
	{		
		private var chessBoard:ChessBoard;
		private var debugClient:DebugClient;
		private var debugBroadcaster:Broadcaster;
		
		[Before]
		public function setUp():void
		{
			debugBroadcaster = new Broadcaster("DebugBroadCaster");
			chessBoard = new ChessBoard();
			debugClient = new DebugClient();
			debugBroadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(debugClient)));
			debugBroadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(chessBoard, {})));
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function testChessBoard():void
		{
			Assert.assertTrue(debugClient.getMetaDataType(MetaData.ADD_CLIENT));
			var name:String = debugClient.getMetaDataType(MetaData.ADD_CLIENT).data.client.name;
			Assert.assertEquals(name, "ChessBoard");
		}
		
		[Test]
		public function testBoardSetup():void
		{
			Assert.fail("Test not made");
		}
	}
}