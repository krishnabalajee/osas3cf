package org.osas3cf.core
{
	import flash.errors.IllegalOperationError;
	
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	
	public class Client implements IClient
	{
		private var broadcasters:Array = [];
		
		public function Client(){}

		public function onMetaData(metaData:MetaData):void{}
		
		final public function addBroadcaster(broadcaster:IBroadcaster, clientVO:ClientVO):void
		{
			broadcasters.push(broadcaster);
			sendMetaData(new MetaData(MetaData.CLIENT_ADDED, clientVO));
		}
		
		final public function removeBroadcaster(name:String):void
		{
			for(var i:String in broadcasters)
			{
				if(broadcasters[i].name == name)
				{
					sendMetaData(new MetaData(MetaData.CLIENT_REMOVED, new ClientVO(this)));
					broadcasters.splice(i, 1);
					return;
				}
			}
		}
		
		final protected function sendMetaData(metaData:MetaData):void
		{
			for each(var broadcaster:IBroadcaster in broadcasters)
			{
				broadcaster.addMetaData(metaData);
			}
		}		
		
		public function get name():String
		{
			throw new IllegalOperationError("Must override name property to extend Client");
		}
	}
}