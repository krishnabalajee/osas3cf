package flexUnitTests
{
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	
	public class DebugClient extends Client
	{
		private var metaDataStore:Array = [];
		private var clientsAdded:Array = [];
		
		public function DebugClient()
		{
			
		}
		
		override public function onMetaData(metaData:MetaData):void
		{
			metaDataStore.push(metaData);
			switch(metaData.type)
			{
				case MetaData.CLIENT_ADDED:
					var client:ClientVO = metaData.data as ClientVO;
					clientsAdded.push(client.client.name);
					break;
			}
		}
		
		public function clientAdded(value:String):Boolean
		{
			for each(var client:String in clientsAdded)
			{
				if(client == value)
					return true;
			}
			return false;
		}
		
		public function get metaData():Array
		{
			return metaDataStore;
		}
		
		public function recievedMetaData(testMetaData:MetaData):Boolean
		{
			for each(var metaData:MetaData in metaDataStore)	
			{
				if(compareMetaData(metaData, testMetaData))
					return true;
			}
			return false;
		}
		
		public function getMetaDataType(type:String):MetaData
		{
			var result:MetaData = null;
			metaDataStore.reverse();
			for each(var metaData:MetaData in metaDataStore)	
			{
				if(metaData.type == type)
					result = metaData;
			}
			metaDataStore.reverse();
			return result;
		}
		
		public function addMetaData(metaData:MetaData):void
		{
			this.sendMetaData(metaData);
		}
		
		public function reset():void
		{
			metaDataStore = [];
		}
		
		private function compareMetaData(metaDataA:MetaData, metaDataB:MetaData):Boolean
		{
			if(metaDataA.type != metaDataB.type)
				return false;
			if(metaDataA.data != metaDataB.data)
				return false;
			return true;
		}
		
		override public function get name():String
		{
			return "DebuggerClient";
		}
	}
}