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
	}
}

internal class SingletonEnforcer{}