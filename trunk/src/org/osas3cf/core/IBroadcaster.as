package org.osas3cf.core
{
	import org.osas3cf.core.data.MetaData;
	
	public interface IBroadcaster
	{
		function addMetaData(metaData:MetaData):void;
		function get name():String;
	}
}