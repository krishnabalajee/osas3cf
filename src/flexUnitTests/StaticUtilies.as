package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.board.Square;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.BoardUtil;
	
	public class StaticUtilies
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
			Assert.assertEquals(BitOper.and(allWhite, allPieces).toString(), allWhite.toString());
		}
		
		[Test]
		public function testContains():void
		{
			Assert.assertEquals(BitOper.contains(testText, "Test").toString(), allBlack.toString());
		}
		
		[Test]
		public function testDoesNotContain():void
		{
			Assert.assertEquals(BitOper.doesNotContain(testText2, "Test").toString(), allWhite.toString());
		}
		
		[Test]
		public function testNot():void
		{
			Assert.assertEquals(BitOper.not(allZeros).toString(), allOnes.toString());
		}
		
		[Test]
		public function testNotX():void
		{
			Assert.assertEquals(BitOper.notX(allWhite, allBlack).toString(), allOnes.toString());
		}
		
		[Test]
		public function testOr():void
		{
			Assert.assertEquals(BitOper.or(allWhite, allBlack).toString(), allPieces.toString());
		}
		
		[Test]
		public function testBoardUtilSquareFunctions():void
		{
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.A1)), Square.A1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.A2)), Square.A2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.A3)), Square.A3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.A4)), Square.A4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.A5)), Square.A5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.A6)), Square.A6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.A7)), Square.A7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.A8)), Square.A8);			
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.B1)), Square.B1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.B2)), Square.B2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.B3)), Square.B3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.B4)), Square.B4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.B5)), Square.B5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.B6)), Square.B6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.B7)), Square.B7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.B8)), Square.B8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.C1)), Square.C1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.C2)), Square.C2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.C3)), Square.C3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.C4)), Square.C4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.C5)), Square.C5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.C6)), Square.C6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.C7)), Square.C7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.C8)), Square.C8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.D1)), Square.D1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.D2)), Square.D2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.D3)), Square.D3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.D4)), Square.D4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.D5)), Square.D5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.D6)), Square.D6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.D7)), Square.D7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.D8)), Square.D8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G1)), Square.G1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G2)), Square.G2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G3)), Square.G3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G4)), Square.G4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G5)), Square.G5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G6)), Square.G6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G7)), Square.G7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G8)), Square.G8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.F1)), Square.F1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.F2)), Square.F2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.F3)), Square.F3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.F4)), Square.F4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.F5)), Square.F5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.F6)), Square.F6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.F7)), Square.F7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.F8)), Square.F8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G1)), Square.G1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G2)), Square.G2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G3)), Square.G3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G4)), Square.G4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G5)), Square.G5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G6)), Square.G6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G7)), Square.G7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.G8)), Square.G8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.H1)), Square.H1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.H2)), Square.H2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.H3)), Square.H3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.H4)), Square.H4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.H5)), Square.H5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.H6)), Square.H6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.H7)), Square.H7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(BoardUtil.squareToArrayNote(Square.H8)), Square.H8);
		}
	}
}