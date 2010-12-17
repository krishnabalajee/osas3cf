package flexUnitTests
{
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.MetaData;
	
	public class DebugClient extends Client
	{
		private var metaDataStore:Array;
		
		public function DebugClient()
		{
			metaDataStore = [];
		}
		
		override public function onMetaData(metaData:MetaData):void
		{
			metaDataStore.push(metaData);
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
			for each(var metaData:MetaData in metaDataStore)	
			{
				if(metaData.type == type)
					return metaData;
			}
			return null;
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