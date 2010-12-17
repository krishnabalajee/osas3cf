package org.osas3cf.core
{
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	
	public interface IClient
	{
		function onMetaData(metaData:MetaData):void;
		function addBroadcaster(broadcaster:IBroadcaster, initVO:ClientVO):void;
		function removeBroadcaster(name:String):void
		function get name():String;
	}
}