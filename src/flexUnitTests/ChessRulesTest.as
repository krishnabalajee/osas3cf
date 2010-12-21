package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.BitBoardGen;
	import org.osas3cf.validation.rules.chess.Diagonals;
	import org.osas3cf.validation.rules.chess.HorizontalVertical;
	import org.osas3cf.validation.rules.chess.KingRule;
	import org.osas3cf.validation.rules.chess.KnightRule;
	import org.osas3cf.validation.rules.chess.PawnRule;
	import org.osas3cf.validation.rules.chess.QueenRule;

	public class ChessRulesTest extends BoardTests
	{			
		private var rules:Array;
		private var colors:Array;
		private var moveGen:BitBoardGen;
		
		[Before]
		public function setUp():void
		{
			rules = [];
			rules.push(new PawnRule());
			rules.push(new KnightRule());
			rules.push(new Diagonals());
			rules.push(new HorizontalVertical());
			rules.push(new QueenRule());
			rules.push(new KingRule()); //King must always be last
			
			colors = ["White","Black"];
			moveGen = new BitBoardGen(rules, colors);
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function testBishopRules():void
		{
			var results:Array = moveGen.execute(new BitBoard(bishopBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D5Attack"]);
			Assert.assertNotNull(results["D5Move"]);
			Assert.assertEquals(bishopResults.toString(), results["D5Attack"].toString());
		}
		
		[Test]
		public function testRookRules():void
		{
			var results:Array = moveGen.execute(new BitBoard(rookBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D5Attack"]);
			Assert.assertNotNull(results["D5Move"]);
			Assert.assertEquals(rookResults.toString(), results["D5Move"].toString());
			Assert.assertEquals(rookResults.toString(), results["D5Attack"].toString());
		}
		
		[Test]
		public function testQueenRules():void
		{
			var results:Array = moveGen.execute(new BitBoard(queenBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D5Attack"]);
			Assert.assertNotNull(results["D5Move"]);
			Assert.assertEquals(queenResults.toString(), results["D5Move"].toString());
			Assert.assertEquals(queenResults.toString(), results["D5Attack"].toString());
		}
		
		[Test]
		public function testKnight():void
		{
			var results:Array = moveGen.execute(new BitBoard(knightBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D5Attack"]);
			Assert.assertNotNull(results["D5Move"]);
			Assert.assertEquals(knigthResults.toString(), results["D5Move"].toString());
			Assert.assertEquals(knigthResults.toString(), results["D5Attack"].toString());
		}
		
		[Test]
		public function testPawn():void
		{
			var results:Array = moveGen.execute(new BitBoard(pawnBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["D7Attack"]);
			Assert.assertNotNull(results["D7Move"]);
			Assert.assertEquals(pawnResults2.toString(), results["D7Attack"].toString());
			Assert.assertEquals(pawnResults.toString(),  results["D7Move"].toString());
		}
		
		[Test]
		public function testKing():void
		{
			var results:Array = moveGen.execute(new BitBoard(kingBoard));
			Assert.assertNotNull(results);
			Assert.assertNotNull(results["C5Attack"]);
			Assert.assertNotNull(results["C5Move"]);
			Assert.assertEquals(kingResults.toString(), results["C5Move"].toString());
			Assert.assertEquals(kingResults.toString(), results["C5Attack"].toString());
		}		
	}
}