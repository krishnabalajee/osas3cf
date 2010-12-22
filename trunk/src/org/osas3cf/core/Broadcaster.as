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
package org.osas3cf.core
{
	import org.osas3cf.core.core;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
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
		
		public function get name():String{return _name;}
		
		private function addClient(clientVO:ClientVO):void
		{
			CONFIG::debug{Debug.out(name + " adding client " + clientVO.client.name, this);}
			clients.push(clientVO.client);
			clientVO.client.addBroadcaster(this, clientVO);
		}
		
		private function removeClient(name:String):void
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
				addMetaData(new MetaData(MetaData.REMOVE_CLIENT, client.name));
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