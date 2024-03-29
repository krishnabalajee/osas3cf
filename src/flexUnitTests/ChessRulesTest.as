package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.board.Square;
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.ChessBitBoards;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.BitBoardGen;
	import org.osas3cf.validation.rules.chess.Diagonals;
	import org.osas3cf.validation.rules.chess.HorizontalVertical;
	import org.osas3cf.validation.rules.chess.KingRule;
	import org.osas3cf.validation.rules.chess.KnightRule;
	import org.osas3cf.validation.rules.chess.PawnRule;
	import org.osas3cf.validation.rules.chess.QueenRule;

	public class ChessRulesTest extends TestingBitBoards
	{			
		private var moveGen:BitBoardGen;
		
		[Before]
		public function setUp():void
		{
			var rules:Array = [];
			rules.push(new PawnRule());
			rules.push(new KnightRule());
			rules.push(new Diagonals());
			rules.push(new HorizontalVertical());
			rules.push(new QueenRule());
			rules.push(new KingRule()); //King must always be last
			
			var colors:Array = ["White","Black"];
			moveGen = new BitBoardGen(rules, colors);
		}
		
		[After]
		public function tearDown():void
		{
			moveGen = null;
		}
		
		[Test]
		public function testBishopRules():void
		{
			var results:Array = moveGen.execute(new BitBoard(bishopBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D5Attack"]);
			Assert.assertNotNull(results["D5Move"]);
			Assert.assertEquals(bishopAttacks.toString(), results["D5Attack"].toString());
			Assert.assertEquals(bishopMoves.toString(), results["D5Move"].toString());
		}
		
		[Test]
		public function testRookRules():void
		{
			var results:Array = moveGen.execute(new BitBoard(rookBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D5Attack"]);
			Assert.assertNotNull(results["D5Move"]);
			Assert.assertEquals(rookMoves.toString(), results["D5Move"].toString());
			Assert.assertEquals(rookAttacks.toString(), results["D5Attack"].toString());
		}
		
		[Test]
		public function testQueenRules():void
		{
			var results:Array = moveGen.execute(new BitBoard(queenBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D5Attack"]);
			Assert.assertNotNull(results["D5Move"]);
			Assert.assertEquals(queenMoves.toString(), results["D5Move"].toString());
			Assert.assertEquals(queenAttacks.toString(), results["D5Attack"].toString());
		}
		
		[Test]
		public function testKnight():void
		{
			var results:Array = moveGen.execute(new BitBoard(knightBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D5Attack"]);
			Assert.assertNotNull(results["D5Move"]);
			Assert.assertEquals(knightMoves.toString(), results["D5Move"].toString());
			Assert.assertEquals(knightAttacks.toString(), results["D5Attack"].toString());
		}
		
		[Test]
		public function testPawn():void
		{
			var results:Array = moveGen.execute(new BitBoard(pawnBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D7Attack"]);
			Assert.assertNotNull(results["D7Move"]);
			Assert.assertEquals(pawnAttacks.toString(), results["D7Attack"].toString());
			Assert.assertEquals(pawnMoves.toString(),  results["D7Move"].toString());
		}
		
		[Test]
		public function testKing():void
		{
			var results:Array = moveGen.execute(new BitBoard(kingBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["C5Attack"]);
			Assert.assertNotNull(results["C5Move"]);
			Assert.assertEquals(kingMoves.toString(), results["C5Move"].toString());
			Assert.assertEquals(kingAttacks.toString(), results["C5Attack"].toString());
		}
		
		[Test]
		public function testIntialPieces():void
		{
			var results:Array = moveGen.execute(new BitBoard(initalBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results[ChessPieces.WHITE + ChessBitBoards.ATTACK]);
			Assert.assertEquals(initalResults.toString(), results[ChessPieces.WHITE + ChessBitBoards.ATTACK].toString());
		}
		
		[Test]
		public function testCastling():void
		{
			var results:Array = moveGen.execute(new BitBoard(castling));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["E1Move"]);
			Assert.assertEquals(castlingMoves.toString(), results["E1Move"].toString());
			
			results = moveGen.execute(new BitBoard(blackCastling));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["E8Move"]);
			Assert.assertEquals(blackCastlingMoves.toString(), results["E8Move"].toString());			
		}
	}
}