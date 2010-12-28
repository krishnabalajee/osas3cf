package flexUnitTests
{
	import flash.geom.Point;
	
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
		public function testArrayToSquare():void
		{
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(0,0)), Square.A1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(1,0)), Square.A2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(2,0)), Square.A3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(3,0)), Square.A4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(4,0)), Square.A5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(5,0)), Square.A6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(6,0)), Square.A7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(7,0)), Square.A8);			
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(0,1)), Square.B1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(1,1)), Square.B2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(2,1)), Square.B3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(3,1)), Square.B4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(4,1)), Square.B5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(5,1)), Square.B6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(6,1)), Square.B7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(7,1)), Square.B8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(0,2)), Square.C1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(1,2)), Square.C2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(2,2)), Square.C3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(3,2)), Square.C4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(4,2)), Square.C5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(5,2)), Square.C6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(6,2)), Square.C7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(7,2)), Square.C8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(0,3)), Square.D1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(1,3)), Square.D2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(2,3)), Square.D3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(3,3)), Square.D4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(4,3)), Square.D5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(5,3)), Square.D6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(6,3)), Square.D7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(7,3)), Square.D8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(0,4)), Square.E1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(1,4)), Square.E2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(2,4)), Square.E3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(3,4)), Square.E4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(4,4)), Square.E5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(5,4)), Square.E6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(6,4)), Square.E7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(7,4)), Square.E8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(0,5)), Square.F1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(1,5)), Square.F2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(2,5)), Square.F3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(3,5)), Square.F4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(4,5)), Square.F5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(5,5)), Square.F6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(6,5)), Square.F7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(7,5)), Square.F8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(0,6)), Square.G1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(1,6)), Square.G2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(2,6)), Square.G3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(3,6)), Square.G4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(4,6)), Square.G5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(5,6)), Square.G6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(6,6)), Square.G7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(7,6)), Square.G8);
			
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(0,7)), Square.H1);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(1,7)), Square.H2);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(2,7)), Square.H3);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(3,7)), Square.H4);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(4,7)), Square.H5);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(5,7)), Square.H6);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(6,7)), Square.H7);
			Assert.assertEquals(BoardUtil.arrayNoteToSquare(new Point(7,7)), Square.H8);
		}
		
		[Test]
		public function testSquareToArray():void
		{
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.A1).toString(), new Point(0,0).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.A2).toString(), new Point(1,0).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.A3).toString(), new Point(2,0).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.A4).toString(), new Point(3,0).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.A5).toString(), new Point(4,0).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.A6).toString(), new Point(5,0).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.A7).toString(), new Point(6,0).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.A8).toString(), new Point(7,0).toString());
			
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.B1).toString(), new Point(0,1).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.B2).toString(), new Point(1,1).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.B3).toString(), new Point(2,1).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.B4).toString(), new Point(3,1).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.B5).toString(), new Point(4,1).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.B6).toString(), new Point(5,1).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.B7).toString(), new Point(6,1).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.B8).toString(), new Point(7,1).toString());
			
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.C1).toString(), new Point(0,2).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.C2).toString(), new Point(1,2).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.C3).toString(), new Point(2,2).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.C4).toString(), new Point(3,2).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.C5).toString(), new Point(4,2).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.C6).toString(), new Point(5,2).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.C7).toString(), new Point(6,2).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.C8).toString(), new Point(7,2).toString());
			
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.D1).toString(), new Point(0,3).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.D2).toString(), new Point(1,3).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.D3).toString(), new Point(2,3).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.D4).toString(), new Point(3,3).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.D5).toString(), new Point(4,3).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.D6).toString(), new Point(5,3).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.D7).toString(), new Point(6,3).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.D8).toString(), new Point(7,3).toString());
			
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.E1).toString(), new Point(0,4).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.E2).toString(), new Point(1,4).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.E3).toString(), new Point(2,4).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.E4).toString(), new Point(3,4).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.E5).toString(), new Point(4,4).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.E6).toString(), new Point(5,4).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.E7).toString(), new Point(6,4).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.E8).toString(), new Point(7,4).toString());
			
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.F1).toString(), new Point(0,5).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.F2).toString(), new Point(1,5).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.F3).toString(), new Point(2,5).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.F4).toString(), new Point(3,5).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.F5).toString(), new Point(4,5).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.F6).toString(), new Point(5,5).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.F7).toString(), new Point(6,5).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.F8).toString(), new Point(7,5).toString());
			
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.G1).toString(), new Point(0,6).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.G2).toString(), new Point(1,6).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.G3).toString(), new Point(2,6).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.G4).toString(), new Point(3,6).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.G5).toString(), new Point(4,6).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.G6).toString(), new Point(5,6).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.G7).toString(), new Point(6,6).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.G8).toString(), new Point(7,6).toString());
			
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.H1).toString(), new Point(0,7).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.H2).toString(), new Point(1,7).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.H3).toString(), new Point(2,7).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.H4).toString(), new Point(3,7).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.H5).toString(), new Point(4,7).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.H6).toString(), new Point(5,7).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.H7).toString(), new Point(6,7).toString());
			Assert.assertEquals(BoardUtil.squareToArrayNote(Square.H8).toString(), new Point(7,7).toString());			
		}
		
		[Test]
		public function testGetTrueSquares():void
		{
			var results:Array = BoardUtil.getTrueSquares(allWhite);
			Assert.assertEquals(16, results.length);
			Assert.assertEquals("A1,B1,C1,D1,E1,F1,G1,H1,A2,B2,C2,D2,E2,F2,G2,H2", results.toString());
		}
		
		[Test]
		public function testIsTrue():void
		{
			Assert.assertTrue(BoardUtil.isTrue(Square.A1, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.B1, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.C1, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.D1, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.E1, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.F1, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.G1, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.H1, allPieces));
			
			Assert.assertTrue(BoardUtil.isTrue(Square.A2, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.B2, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.C2, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.D2, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.E2, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.F2, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.G2, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.H2, allPieces));
			
			Assert.assertTrue(BoardUtil.isTrue(Square.A8, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.B8, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.C8, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.D8, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.E8, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.F8, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.G8, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.H8, allPieces));
			
			Assert.assertTrue(BoardUtil.isTrue(Square.A7, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.B7, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.C7, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.D7, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.E7, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.F7, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.G7, allPieces));
			Assert.assertTrue(BoardUtil.isTrue(Square.H7, allPieces));				
		}
		
		[Test]
		public function testSum():void
		{
			Assert.assertEquals(BitOper.sum(allZeros),  0);
			Assert.assertEquals(BitOper.sum(allOnes),   64);
			Assert.assertEquals(BitOper.sum(allPieces), 32);
			Assert.assertEquals(BitOper.sum(allWhite),  16);
			Assert.assertEquals(BitOper.sum(allBlack),  16);
			Assert.assertEquals(BitOper.sum(testText),  16);
		}
	}
}