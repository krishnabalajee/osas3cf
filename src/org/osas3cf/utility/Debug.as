package org.osas3cf.utility
{
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class Debug
	{
		public static var instance:Debug;
		
		private var monster:MonsterDebugger;
		
		public static function getInstance(app:Object = null):Debug
		{
			if( instance == null ) instance = new Debug(new SingletonEnforcer(), app);
			return instance;
		}
		
		public function Debug( pvt:SingletonEnforcer, app:Object = null )
		{
			//Initialize class
			monster = new MonsterDebugger(app);
			MonsterDebugger.clearTraces();
		}
		
		public static function out(message:Object, src:Object = null):void
		{
			MonsterDebugger.trace(src, message);
			if(src) message = src + ": " + message;
			trace(message);	
		}
		
		public static function traceBitBoard(bitBoard:Array):void
		{
			Debug.out("");
			Debug.out("8 "+bitBoard[7]);
			Debug.out("7 "+bitBoard[6]);
			Debug.out("6 "+bitBoard[5]);
			Debug.out("5 "+bitBoard[4]);
			Debug.out("4 "+bitBoard[3]);
			Debug.out("3 "+bitBoard[2]);
			Debug.out("2 "+bitBoard[1]);
			Debug.out("1 "+bitBoard[0]);
			Debug.out(["  A","B","C","D","E","F","G","H"]);
			Debug.out("");
		}
	}
}

internal class SingletonEnforcer{}