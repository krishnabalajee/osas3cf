package org.osas3cf.core
{
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.core.core;
	CONFIG::debug{import org.osas3cf.utility.Debug;}
	
	/**
	 * Broadcaster is meant to be wrapped by another class that acts as the broadcaster to the
	 * applications clients.  This class is used by the wrapper to hand off to cilents which
	 * reduces the exposure to other public functions in the wrapper that are needed however
	 * should not be exposed to the clients.
	 * 
	 * @param name of the wrapper broad baster
	 * 
	 * @example The following code sets the volume level for your sound:
	 * <listing version="3.0">
	 * 	
	 * </listing> 
	 * 
	 **/
	public class Broadcaster implements IBroadcaster
	{
		private var clients:Array = [];
		private var _name:String;
		
		public function Broadcaster(name:String = "Broadcaster")
		{
			_name = name;
		}
		
		public function addMetaData(metaData:MetaData):void
		{
			metaData.core::source = name;
			CONFIG::traceMetaData{CONFIG::debug{Debug.out(metaData, null);}}
			updateClients(metaData);
			
			switch(metaData.type)
			{
				case MetaData.REMOVE_CLIENT:
					removeClient(metaData.data as String);
					break;
				case MetaData.ADD_CLIENT:
					addClient(metaData.data as ClientVO);
					break;
				case MetaData.CLEAN_UP:
					cleanUp();
				break;
			}
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function addClient(clientVO:ClientVO):void
		{
			CONFIG::debug{Debug.out(name + " adding client " + clientVO.cilent.name, this);}
			clients.push(clientVO.cilent);
			clientVO.cilent.addBroadcaster(this, clientVO);
		}
		
		public function removeClient(name:String):void
		{
			for(var i:String in clients)
			{
				if(clients[i].name == name)
				{
					CONFIG::debug{Debug.out(this.name + " removing client " + name, this)};
					clients[i].removeBroadcaster(this.name);
					clients.splice(i, 1);
					return;
				}	
			}
		}
		
		private function cleanUp():void
		{
			for each(var client:IClient in clients)
				removeClient(client.name);
			clients = null;
		}
		
		private function updateClients(metaData:MetaData):void
		{
			for each(var client:IClient in clients)
			{
				client.onMetaData(metaData);
			}
		}		
	}
}