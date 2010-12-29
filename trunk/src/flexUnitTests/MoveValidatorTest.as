package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.board.Square;
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.core.data.StateVO;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.metadata.BitBoardMetaData;
	import org.osas3cf.data.BitBoardTypes;
	import org.osas3cf.data.vo.BoardVO;
	import org.osas3cf.data.metadata.MoveMetaData;
	import org.osas3cf.data.vo.MoveVO;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.ChessBitBoardManger;
	import org.osas3cf.validation.MoveValidator;

	public class MoveValidatorTest extends TestingBitBoards
	{		
		private var debugger:DebugClient;
		private var moveValidator:MoveValidator;
		private var broadcaster:Broadcaster
		
		protected var pD4:Array = [
			[1,1,1,1,1,1,1,1], //1
			[1,1,1,0,1,1,1,1], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,1,0,0,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,0,0,0,0,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H
		
		[Before]
		public function setUp():void
		{
			broadcaster = new Broadcaster();
			debugger = new DebugClient();
			moveValidator = new MoveValidator();
			
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(debugger)));
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(moveValidator)));
		}
		
		[After]
		public function tearDown():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			broadcaster = null;
			debugger = null;
			moveValidator = null;
		}
		
		[Test]
		public function testSetup():void
		{
			Assert.assertTrue(debugger.clientAdded(MoveValidator.NAME));
			Assert.assertTrue(debugger.clientAdded(ChessBitBoardManger.NAME));
		}
		
		[Test]
		public function testUpdatingBroad():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES,null, new BitBoard(initalBoard))));
			var bbmetaData:BitBoardMetaData = debugger.getMetaDataType(BitBoardMetaData.UPDATED) as BitBoardMetaData;
			Assert.assertNotNull(bbmetaData);
			Assert.assertTrue(bbmetaData.data is Array);
			Assert.assertEquals(bbmetaData.data[BitBoardTypes.BOARD].toString(), initalBoard);
			Assert.assertEquals(bbmetaData.data[ChessPieces.WHITE+BitBoardTypes.ATTACK].toString(), initalResults);
		}
		
		[Test]
		public function testMovingPiece():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES, null, new BitBoard(initalBoard))));
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.SUBMIT_MOVE, new MoveVO(ChessPieces.WHITE + ChessPieces.PAWN, Square.D2, Square.D4)));
			var bbmetaData:BitBoardMetaData = debugger.getMetaDataType(BitBoardMetaData.EVALUATED) as BitBoardMetaData;
			Assert.assertNotNull(bbmetaData);
			Assert.assertTrue(bbmetaData.data is Array);
			Assert.assertEquals(bbmetaData.data[BitBoardTypes.ALL_WHITE].toString(), pD4);
		}

		[Test]
		public function testInvalidMove():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES,null, new BitBoard(initalBoard))));
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.SUBMIT_MOVE, new MoveVO(ChessPieces.WHITE + ChessPieces.PAWN, Square.D2, Square.E1)));
			var moveMetaData:MoveMetaData = debugger.getMetaDataType(MoveMetaData.INVALID_MOVE) as MoveMetaData;
			Assert.assertNotNull(moveMetaData);
			Assert.assertTrue(moveMetaData.data is MoveVO);
			Assert.assertEquals(moveMetaData.data["piece"], ChessPieces.WHITE + ChessPieces.PAWN);
		}
		
		[Test]
		public function testNoPieceOnSquare():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES,null, new BitBoard(emptyBoard))));
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.SUBMIT_MOVE, new MoveVO(ChessPieces.WHITE + ChessPieces.PAWN, Square.D2, Square.E1)));
			var moveMetaData:MoveMetaData = debugger.getMetaDataType(MoveMetaData.INVALID_MOVE) as MoveMetaData;
			Assert.assertNotNull(moveMetaData);
			Assert.assertTrue(moveMetaData.data is MoveVO);
			Assert.assertEquals(moveMetaData.data["piece"], ChessPieces.WHITE + ChessPieces.PAWN);
		}

		[Test]
		public function testPutOwnKingInCheck():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES,null, new BitBoard(putKingInCheck))));
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.SUBMIT_MOVE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.B4, Square.D4)));
			var moveMetaData:MoveMetaData = debugger.getMetaDataType(MoveMetaData.INVALID_MOVE) as MoveMetaData;
			Assert.assertNotNull(moveMetaData);
			Assert.assertTrue(moveMetaData.data is MoveVO);
			Assert.assertEquals(moveMetaData.data["piece"], ChessPieces.WHITE + ChessPieces.ROOK);
		}
		
		[Test]
		public function testMovingWhenKingInCheck():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES,null, new BitBoard(kingInCheck))));
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.SUBMIT_MOVE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.E4, Square.H4)));
			var moveMetaData:MoveMetaData = debugger.getMetaDataType(MoveMetaData.INVALID_MOVE) as MoveMetaData;
			Assert.assertNotNull(moveMetaData);
			Assert.assertTrue(moveMetaData.data is MoveVO);
			Assert.assertEquals(moveMetaData.data["piece"], ChessPieces.WHITE + ChessPieces.ROOK);
		}
		
		[Test]
		public function testSavingKingFromCheck():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new BoardVO(BoardVO.PIECES,null, new BitBoard(kingInCheck))));
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.SUBMIT_MOVE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.E4, Square.B4)));
			var moveMetaData:MoveMetaData = debugger.getMetaDataType(MoveMetaData.MOVE_PIECE) as MoveMetaData;
			Assert.assertNotNull(moveMetaData);
			Assert.assertTrue(moveMetaData.data is MoveVO);
			Assert.assertEquals(moveMetaData.data["piece"], ChessPieces.WHITE + ChessPieces.ROOK);
		}
	}
}