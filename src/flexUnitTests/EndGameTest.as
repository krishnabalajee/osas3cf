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
	import org.osas3cf.data.vo.BoardVO;
	import org.osas3cf.data.metadata.MoveMetaData;
	import org.osas3cf.data.vo.MoveVO;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.ChessBitBoardManger;
	import org.osas3cf.validation.EndGame;
	
	public class EndGameTest
	{		
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
		
		private var debugger:DebugClient;
		private var broadcaster:Broadcaster;
		private var endGameClient:EndGame;
		
		private var whiteKingInCheck:Array = [
					[0,k,0,0,0,0,0,0], //1
					[0,p,0,0,0,0,0,0], //2
					[0,0,0,0,0,0,0,0], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,0,0,Q,0], //6
					[0,0,0,0,0,0,0,0], //7
					[0,0,0,0,0,0,K,0]];//8
				  // A B C D E F G H
		private var blackKingInCheck:Array = [
					[0,k,0,0,0,0,0,0], //1
					[0,p,0,0,0,0,0,0], //2
					[0,0,0,0,0,0,0,0], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,0,0,0,0], //6
					[0,0,0,0,0,0,0,0], //7
					[0,r,0,0,0,0,K,0]];//8
				  // A B C D E F G H
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
		private var blackKingInCheckmate:Array = [
					[0,k,0,0,0,0,0,0], //1
					[0,p,0,0,0,p,0,p], //2
					[0,0,0,0,0,0,0,Q], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,0,0,0,R], //6
					[0,R,0,r,0,0,0,0], //7
					[0,0,0,0,r,0,K,0]];//8
				  // A B C D E F G H
		private var whiteKingEscapeCheckmate:Array = [
					[0,k,0,0,0,0,0,0], //1
					[0,Q,0,0,0,p,0,p], //2
					[0,0,0,0,0,0,0,0], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,P,0,0,0], //6
					[0,0,0,0,0,0,0,0], //7
					[0,0,0,0,0,0,K,0]];//8
				  // A B C D E F G H
		private var blackKingEscapeCheckmate:Array = [
					[0,k,0,0,0,0,0,0], //1
					[0,0,0,0,0,p,0,p], //2
					[0,0,0,0,0,0,0,0], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,0,0,0,0], //6
					[0,0,0,r,0,0,0,0], //7
					[Q,0,0,0,r,0,K,0]];//8
				  // A B C D E F G H	
		private var whiteStalemate:Array = [
					[k,0,0,0,0,0,0,0], //1
					[0,0,0,0,0,0,0,0], //2
					[0,Q,0,0,0,0,0,0], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,0,0,0,0], //6
					[0,0,0,0,0,0,0,0], //7
					[0,0,0,0,0,0,K,0]];//8
				  // A B C D E F G H
		private var blackStalemate:Array = [
					[k,0,0,0,0,0,0,0], //1
					[0,0,0,0,0,0,0,0], //2
					[0,0,0,0,0,0,0,0], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,0,0,0,b], //6
					[r,0,0,0,0,0,0,r], //7
					[0,0,0,0,0,0,K,0]];//8
				  // A B C D E F G H
		private var notStalemate:Array = [
					[k,0,0,0,0,0,0,0], //1
					[0,0,0,0,0,0,0,0], //2
					[0,0,0,P,0,0,0,0], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,0,0,0,b], //6
					[0,0,0,0,0,0,0,r], //7
					[0,0,0,0,0,0,K,0]];//8
				  // A B C D E F G H		
		
		private var draw:Array = [
					[k,0,0,0,0,0,0,0], //1
					[0,0,0,0,0,0,0,0], //2
					[0,0,0,0,0,0,0,0], //3
					[0,0,0,0,0,0,0,0], //4
					[0,0,0,0,0,0,0,0], //5
					[0,0,0,0,0,0,0,0], //6
					[0,0,0,0,0,0,0,0], //7
					[0,0,0,0,0,0,K,0]];//8
				  // A B C D E F G H
		
		[Before]
		public function setUp():void
		{
			broadcaster = new Broadcaster();
			debugger = new DebugClient();
			endGameClient = new EndGame();
			
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(debugger)));
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(endGameClient)));
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(new ChessBitBoardManger())));
		}
		
		[After]
		public function tearDown():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			broadcaster = null;
			debugger = null;
			endGameClient = null;
		}
		
		[Test]
		public function testEndGame():void
		{
			Assert.assertTrue(debugger.clientAdded(endGameClient.name));
		}
		
		[Test]
		public function testCheckDetection():void
		{
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.BLACK + ChessPieces.QUEEN, Square.G7, Square.G6)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(whiteKingInCheck))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			debugger.reset();
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.B4, Square.B8)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(blackKingInCheck))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			debugger.reset();
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.BLACK + ChessPieces.QUEEN, Square.H4, Square.B2)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(whiteKingEscapeCheckmate))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			debugger.reset();
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.E1, Square.E8)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(blackKingEscapeCheckmate))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.CHECK));
		}
		
		[Test]
		public function testCheckmateDetection():void
		{
			//Valid Checkmates
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.E1, Square.E8)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(blackKingInCheckmate))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.CHECKMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.DRAW));
			debugger.reset();			
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.BLACK + ChessPieces.QUEEN, Square.E5, Square.B2)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(whiteKingInCheckmate))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.CHECKMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.DRAW));
			debugger.reset();

			//Invalid checkmates
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.BLACK + ChessPieces.QUEEN, Square.H4, Square.B2)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(whiteKingEscapeCheckmate))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECKMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.DRAW));
			debugger.reset();
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.E1, Square.E8)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(blackKingEscapeCheckmate))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECKMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.STALEMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.DRAW));
		}
		
		[Test]
		public function testStalemate():void
		{
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.BLACK + ChessPieces.QUEEN, Square.B8, Square.B3)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(whiteStalemate))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.STALEMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECKMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.DRAW));
			debugger.reset();
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.A7, Square.H7)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(blackStalemate))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.STALEMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECKMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.DRAW));
			debugger.reset();
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.WHITE + ChessPieces.ROOK, Square.A7, Square.H7)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(notStalemate))));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.STALEMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECKMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECK));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.DRAW));
		}
		
		[Test]
		public function testDraw():void
		{
			broadcaster.addMetaData(new MoveMetaData(MoveMetaData.MOVE_PIECE, new MoveVO(ChessPieces.WHITE + ChessPieces.KING, Square.A2, Square.A1)));
			broadcaster.addMetaData(new MetaData(MetaData.STATE_CHANGE, new StateVO(BoardVO.PIECES, null, new BitBoard(draw))));
			Assert.assertNotNull(debugger.getMetaDataType(MoveMetaData.DRAW));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.STALEMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECKMATE));
			Assert.assertNull(debugger.getMetaDataType(MoveMetaData.CHECK));			
		}
	}
}