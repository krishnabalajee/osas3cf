package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.utility.BitOper;
	
	public class BitOperTest
	{		
		private var allZeros:Array =  [[0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0]];
		
		private var allOnes:Array   = [[1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1]];
		
		private var allPieces:Array = [[1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1]];
		
		private var allWhite:Array =  [[1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0]];
		
		private var allBlack:Array =  [[0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [1,1,1,1,1,1,1,1],
									   [1,1,1,1,1,1,1,1]];
		
		private var testText:Array =  [[0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   [0,0,0,0,0,0,0,0],
									   ["Test","Test","Test","Test","Test","Test","Test","Test"],
									   ["Test","Test","Test","Test","Test","Test","Test","Test"]];
		
		private var testText2:Array =  [[0,0,0,0,0,0,0,0],
									    [0,0,0,0,0,0,0,0],
										["Test","Test","Test","Test","Test","Test","Test","Test"],
										["Test","Test","Test","Test","Test","Test","Test","Test"],
										["Test","Test","Test","Test","Test","Test","Test","Test"],
										["Test","Test","Test","Test","Test","Test","Test","Test"],
										["Test","Test","Test","Test","Test","Test","Test","Test"],
										["Test","Test","Test","Test","Test","Test","Test","Test"]];
		
		[Test]
		public function testAnd():void
		{
			var result:Array = BitOper.and(allWhite, allPieces);
			if(result.toString() == allWhite.toString())
				Assert.assertTrue("And operation passed");
			else
				Assert.fail("And operation return faulty result: " + result.toString());
		}
		
		[Test]
		public function testContains():void
		{
			var result:Array = BitOper.contains(testText, "Test");
			if(result.toString() == allBlack.toString())
				Assert.assertTrue("Contains operation passed");
			else
				Assert.fail("Contains operation return faulty result: " + result.toString());
		}
		
		[Test]
		public function testDoesNotContain():void
		{
			var result:Array = BitOper.doesNotContain(testText2, "Test");
			if(result.toString() == allWhite.toString())
				Assert.assertTrue("Contains operation passed");
			else
				Assert.fail("Contains operation return faulty result: " + result.toString());
		}
		
		[Test]
		public function testNot():void
		{
			var result:Array = BitOper.not(allZeros);
			if(result.toString() == allOnes.toString())
				Assert.assertTrue("Not operation passed");
			else
				Assert.fail("Not operation return faulty result: " + result.toString());
		}
		
		[Test]
		public function testNotX():void
		{
			var result:Array = BitOper.notX(allWhite, allBlack);
			if(result.toString() == allOnes.toString())
				Assert.assertTrue("NotX operation passed");
			else
				Assert.fail("NotX operation return faulty result: " + result.toString());
		}
		
		[Test]
		public function testOr():void
		{
			var result:Array = BitOper.or(allWhite, allBlack);
			if(result.toString() == allPieces.toString())
				Assert.assertTrue("Or operation passed");
			else
				Assert.fail("Or operation return faulty result: " + result.toString());
		}
	}
}