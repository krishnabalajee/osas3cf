package flexUnitTests
{
	import flash.geom.Point;
	
	import flexunit.framework.Assert;
	
	import org.osas3cf.board.Pieces;
	import org.osas3cf.board.Square;
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.vo.BoardVO;
	import org.osas3cf.data.metadata.MoveMetaData;
	import org.osas3cf.data.vo.MoveVO;
	import org.osas3cf.utility.BoardUtil;

	public class PiecesTest
	{		
		private var pieces:Pieces;
		private var broadcaster:Broadcaster;
		private var debugClient:DebugClient;
		
		[Before]
		public function setUp():void
		{
			broadcaster = new Broadcaster("TestBroadCaster");
			debugClient = new DebugClient();
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(debugClient)));
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(new Pieces(), {row:8, column:8})));
		}
		
		[After]
		public function tearDown():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			debugClient = null;
			broadcaster = null;
		}		
		
		[Test]
		public function testMovingPiece():void
		{
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO("TestPiece", Square.A1, Square.A8)));
			var result:MetaData = debugClient.getMetaDataType(MetaData.STATE_CHANGE);
			Assert.assertNotNull(result);
			Assert.assertTrue(result.data is BoardVO);
			var state:BoardVO = result.data as BoardVO;
			Assert.assertEquals(state.type, BoardVO.PIECES);
			Assert.assertTrue(state.newState is BitBoard);
			Assert.assertTrue(state.oldState is BitBoard);
			var bitBoard:BitBoard = state.newState as BitBoard;
			Assert.assertNotNull(bitBoard[7][7]);
			var point:Point = BoardUtil.squareToArrayNote(Square.A8);
			Assert.assertEquals(bitBoard[point.x][point.y],"TestPiece");
		}

		[Test]
		public function testPromotePiece():void
		{
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.PROMOTE_PIECE, new MoveVO("Queen", Square.C3)));
			var result:MetaData = debugClient.getMetaDataType(MetaData.STATE_CHANGE);
			Assert.assertNotNull(result);
			Assert.assertTrue(result.data is BoardVO);
			var state:BoardVO = result.data as BoardVO;
			Assert.assertEquals(state.type, BoardVO.PIECES);
			Assert.assertTrue(state.newState is BitBoard);
			Assert.assertTrue(state.oldState is BitBoard);
			var bitBoard:BitBoard = state.newState as BitBoard;
			Assert.assertNotNull(bitBoard[7][7]);
			var point:Point = BoardUtil.squareToArrayNote(Square.C3);
			Assert.assertEquals(bitBoard[point.x][point.y],"Queen");
		}		
		
		[Test]
		public function testCapturingPiece():void
		{
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.CAPTURE_PIECE, new MoveVO("TestPiece",Square.A8)));
			var result:MetaData = debugClient.getMetaDataType(MetaData.STATE_CHANGE);
			Assert.assertNotNull(result);
			Assert.assertTrue(result.data is BoardVO);
			var state:BoardVO = result.data as BoardVO;
			Assert.assertEquals(state.type, BoardVO.CAPTURED_PIECES);
			Assert.assertTrue(state.newState is Array);
			Assert.assertTrue(state.oldState is Array);
			var capturedPieces:Array = state.newState as Array;
			var oldState:Array = state.oldState as Array;
			Assert.assertEquals(oldState.length, 0);
			Assert.assertEquals(capturedPieces.length, 1);
			Assert.assertEquals(capturedPieces[0], "TestPiece");
		}
	}
}