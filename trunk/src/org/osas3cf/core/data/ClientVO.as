package org.osas3cf.core.data
{
	import org.osas3cf.core.IClient;
	
	public class ClientVO
	{
		private var _client:IClient;
		private var _params:Object;
		
		public function ClientVO(client:IClient, params:Object = null)
		{
			_client = client;
			_params = params;
		}
		
		public function get cilent():IClient	{return _client;}
		public function get params():Object		{return _params;}
		public function toString():String		{return "ClientVO {client: "+cilent.name+", params: "+params+"}";}
	}
}