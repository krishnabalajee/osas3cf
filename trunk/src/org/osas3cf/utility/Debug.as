/**
 * The MIT License
 * Copyright (c) 2010 Craig Simpson
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 **/
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