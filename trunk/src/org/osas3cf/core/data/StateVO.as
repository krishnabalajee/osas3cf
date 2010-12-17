package org.osas3cf.core.data
{
	public class StateVO
	{
		private var _type:String;
		private var _oldState:Object;
		private var _newState:Object;
		
		public function StateVO(type:String, oldState:Object, newState:Object)
		{
			_type = type;
			_oldState = oldState;
			_newState = newState;
		}
		
		public function get type():String		{return _type;}
		public function get oldState():Object	{return _oldState;}
		public function get newState():Object	{return _newState;}
		public function toString():String 		{return "StateVO {type: "+type+", oldState: "+oldState+", newState: "+newState+"}"}
		
	}
}