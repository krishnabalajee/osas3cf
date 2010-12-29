package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import mx.effects.Move;
	
	import org.osas3cf.board.ChessBoard;
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.core.data.StateVO;
	import org.osas3cf.data.BitBoardMetaData;
	import org.osas3cf.data.MoveMetaData;
	
	public class ChessBoardTest extends TestingBitBoards
	{		
		private var chessBoard:ChessBoard;
		private var debugClient:DebugClient;
		private var broadcaster:Broadcaster;
		
		private var k:String = ChessPieces.WHITE + ChessPieces.KING;
		private var q:String = ChessPieces.WHITE + ChessPieces.QUEEN;
		private var r:String = ChessPieces.WHITE + ChessPieces.ROOK;
		private var b:String = ChessPieces.WHITE + ChessPieces.BISHOP;
		private var n:String = ChessPieces.WHITE + ChessPieces.KNIGHT;
		private var p:String = ChessPieces.WHITE + ChessPieces.PAWN;
		
		private var K:String = ChessPieces.BLACK + ChessPieces.KING;
		private var Q:String = ChessPieces.BLACK + ChessPieces.QUEEN;
		private var R:String = ChessPieces.BLACK + ChessPieces.ROOK;
		private var B:String = ChessPieces.BLACK + ChessPieces.BISHOP;
		private var N:String = ChessPieces.BLACK + ChessPieces.KNIGHT;
		private var P:String = ChessPieces.BLACK + ChessPieces.PAWN;		

		private var whiteKingInCheckmate:Array = [
			[0,k,0,0,0,0,0,0], //1
			[0,Q,0,0,R,p,0,p], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,0,0,0,0,B,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,0,0,0,K,0]];//8
		  // A B C D E F G H
		
		[Before]
		public function setUp():void
		{
			chessBoard = new ChessBoard();
			debugClient = new DebugClient();
			broadcaster = new Broadcaster();
			chessBoard.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(debugClient)));
		}
		
		[After]
		public function tearDown():void
		{
			chessBoard.addMetaData(new MetaData(MetaData.CLEAN_UP));
			chessBoard = null;
			debugClient = null;
		}
		
		[Test]
		public function testChessBoard():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(chessBoard)));
			Assert.assertNotNull(debugClient.getMetaDataType(MetaData.STATE_CHANGE));
			Assert.assertNotNull(debugClient.getMetaDataType(BitBoardMetaData.UPDATED));
		}
		
		[Test]
		public function testBoardSetup():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(chessBoard, {setup:rookBoard})));
			Assert.assertNotNull(debugClient.getMetaDataType(MetaData.STATE_CHANGE));
			Assert.assertNotNull(debugClient.getMetaDataType(BitBoardMetaData.UPDATED));
			var state:StateVO = debugClient.getMetaDataType(MetaData.STATE_CHANGE).data as StateVO;
			var bitBoards:Array = debugClient.getMetaDataType(BitBoardMetaData.UPDATED).data as Array;
			Assert.assertEquals(rookMoves.toString(), bitBoards["D5Move"].toString());
		}
		
		[Test]
		public function testCheckmate():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(chessBoard, {setup:whiteKingInCheckmate})));
			Assert.assertNotNull(debugClient.getMetaDataType(MoveMetaData.CHECKMATE));		
		}
	}
}