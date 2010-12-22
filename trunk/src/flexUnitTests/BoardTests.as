package flexUnitTests
{
	import org.osas3cf.board.ChessPieces;

	public class BoardTests
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
		
		protected var emptyBoard:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,0,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,0,0,0,0,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H
		
		protected var rookBoard:Array = [
			[0,0,0,0,0,0,0,R], //1
			[0,0,0,p,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,r,0,0,R,0], //5
			[0,0,0,0,0,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H
		
		protected var rookResults:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,0,0,0,0,0], //2
			[0,0,0,1,0,0,0,0], //3
			[0,0,0,1,0,0,0,0], //4
			[1,1,1,0,1,1,1,0], //5
			[0,0,0,1,0,0,0,0], //6
			[0,0,0,1,0,0,0,0], //7
			[0,0,0,1,0,0,0,0]];//8
		// A B C D E F G H
		
		protected var bishopBoard:Array =[
			[0,0,0,k,0,0,0,0], //1
			[K,0,0,0,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,B,0,0,0,0], //5
			[0,0,0,0,p,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[r,0,0,0,0,0,0,b]];//8
		  // A B C D E F G H
		
		protected var bishopResults:Array =[
			[0,0,0,0,0,0,0,1], //1
			[0,0,0,0,0,0,1,0], //2
			[0,1,0,0,0,1,0,0], //3
			[0,0,1,0,1,0,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,0,1,0,1,0,0,0], //6
			[0,1,0,0,0,0,0,0], //7
			[1,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H		
		
		protected var queenBoard:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,B,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,q,0,0,p,0], //5
			[0,0,0,0,0,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,0,Q,0,0,0]];//8
		  // A B C D E F G H
		
		protected var queenResults:Array = [
			[0,0,0,0,0,0,0,1], //1
			[1,0,0,1,0,0,1,0], //2
			[0,1,0,1,0,1,0,0], //3
			[0,0,1,1,1,0,0,0], //4
			[1,1,1,0,1,1,0,0], //5
			[0,0,1,1,1,0,0,0], //6
			[0,1,0,1,0,1,0,0], //7
			[1,0,0,1,0,0,1,0]];//8
		  // A B C D E F G H		
		
		protected var knightBoard:Array = [
			[N,0,0,0,0,0,0,n], //1
			[0,0,0,0,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,P,0,0], //4
			[0,0,0,n,0,0,0,0], //5
			[0,0,0,0,0,0,0,0], //6
			[0,0,n,0,0,0,0,0], //7
			[N,0,0,0,0,0,0,n]];//8
		  // A B C D E F G H
		
		protected var knigthResults:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,0,0,0,0,0], //2
			[0,0,1,0,1,0,0,0], //3
			[0,1,0,0,0,1,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,1,0,0,0,1,0,0], //6
			[0,0,0,0,1,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H	
		
		protected var pawnBoard:Array = [
			[0,0,0,0,0,0,0,0], //1
			[p,0,p,p,p,p,p,p], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,0,p,0,0,0,0,0], //6
			[0,0,0,P,0,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H
		
		protected var pawnResults:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,0,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,1,0,0,0,0], //5
			[0,0,0,1,0,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H
		
		protected var pawnResults2:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,0,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,0,1,0,0,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H
		
		protected var kingBoard:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,0,0,0,0,0], //2
			[0,0,k,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,K,0,0,0,0,0], //5
			[0,0,0,0,0,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,r,0,0,0,0]];//8
		  // A B C D E F G H
		
		protected var kingResults:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,0,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,1,0,0,0,0,0,0], //5
			[0,1,1,0,0,0,0,0], //6
			[0,0,0,0,0,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H
		
		public function BoardTests(){}
	}
}