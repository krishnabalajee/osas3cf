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
package org.osas3cf.core.data
{	
	public class MetaData
	{
		public static const CLIENT_ADDED:String 	= "ClientAdded";
		public static const CLIENT_REMOVED:String 	= "ClientRemoved";
		
		public static const REMOVE_CLIENT:String 	= "RemoveClient";
		public static const ADD_CLIENT:String 		= "AddClient";
		
		public static const STATE_CHANGE:String 	= "StateChange";
		
		public static const CLEAN_UP:String 		= "CleanUp";
		
		private var _source:String = "Core";
		private var _type:String;
		private var _data:Object;
		
		public function MetaData(type:String, data:Object = null)
		{
			_type = type;
			_data = data;
		}
		
		public function toString():String
		{
			return "MetaData: {type: " + type + ", source: " + source + ", vo: " + data + "}";
		}
		
		public function get type():String 	{return _type;}
		public function get source():String {return _source;}
		public function get data():Object 	{return _data;}
		
		/**
		 * @private
		 * This allows the core code to modify the source of the meta data, but is unavvliable to other high level packages.
		 **/
		core function set source(value:String):void
		{
			_source = value;
		}
	}
}