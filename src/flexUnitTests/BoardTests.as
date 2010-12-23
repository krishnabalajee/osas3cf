package flexUnitTests
{
	import org.osas3cf.board.ChessPieces;

	public class BoardTests
	{
		protected var k:String = ChessPieces.WHITE + ChessPieces.KING;
		protected var q:String = ChessPieces.WHITE + ChessPieces.QUEEN;
		protected var r:String = ChessPieces.WHITE + ChessPieces.ROOK;
		protected var b:String = ChessPieces.WHITE + ChessPieces.BISHOP;
		protected var n:String = ChessPieces.WHITE + ChessPieces.KNIGHT;
		protected var p:String = ChessPieces.WHITE + ChessPieces.PAWN;
		
		protected var K:String = ChessPieces.BLACK + ChessPieces.KING;
		protected var Q:String = ChessPieces.BLACK + ChessPieces.QUEEN;
		protected var R:String = ChessPieces.BLACK + ChessPieces.ROOK;
		protected var B:String = ChessPieces.BLACK + ChessPieces.BISHOP;
		protected var N:String = ChessPieces.BLACK + ChessPieces.KNIGHT;
		protected var P:String = ChessPieces.BLACK + ChessPieces.PAWN;
		
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
		
		protected var initalBoard:Array = [
			[r,n,b,q,k,b,n,r], //1
			[p,p,p,p,p,p,p,p], //2
			[0,0,0,0,0,0,0,0], //3
			[0,0,0,0,0,0,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,0,0,0,0,0,0,0], //6
			[P,P,P,P,P,P,P,P], //7
			[R,N,B,Q,K,B,N,R]];//8
		  // A B C D E F G H
		
		protected var initalResults:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,0,0,0,0,0,0,0], //2
			[1,0,1,0,0,1,0,1], //3
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
			[0,0,1,1,0,0,0,0], //6
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
		
		protected var putKingInCheck:Array = [
			[0,0,0,0,0,0,0,0], //1
			[0,k,0,0,0,0,0,0], //2
			[0,0,0,0,0,0,0,0], //3
			[0,r,0,0,0,0,0,0], //4
			[0,0,0,0,0,0,0,0], //5
			[0,0,0,0,0,0,0,0], //6
			[0,Q,0,0,0,0,0,0], //7
			[0,0,0,0,0,0,0,0]];//8
		  // A B C D E F G H
		
		public function BoardTests(){}
	}
}