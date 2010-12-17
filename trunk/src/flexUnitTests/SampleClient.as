package flexUnitTests
{
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.MetaData;
	
	public class SampleClient extends Client
	{
		public var added:Boolean;
		public var recieveMetaData:Boolean;
		public var removed:Boolean;
		
		public function SampleClient(){}
		
		override public function onMetaData(metaData:MetaData):void
		{
			if(metaData.type == "TestMetaData")
			{
				recieveMetaData = true;
			}
			if(metaData.type == MetaData.CLIENT_ADDED)
			{
				added = true;
				removed = false;
				recieveMetaData = false;
			}
			if(metaData.type == MetaData.REMOVE_CLIENT)
			{
				removed = true;
				recieveMetaData = false;
				added = false;
			}
		}
		
		override public function get name():String {return "Sample";}
	}
}