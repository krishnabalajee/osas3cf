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