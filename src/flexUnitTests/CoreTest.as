package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	
	public class CoreTest
	{		
		private var client:Client;
		private var debugClient:DebugClient;
		private var broadcaster:Broadcaster;
		
		[Before]
		public function setUp():void
		{
			client = new Client();
			debugClient = new DebugClient();
			broadcaster = new Broadcaster();
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(debugClient)));
		}
		
		[After]
		public function tearDown():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			client = null;
			debugClient = null;
			broadcaster = null;
		}
		
		[Test]
		public function testAddBroadcaster():void
		{
			Assert.assertNotNull(debugClient.getMetaDataType(MetaData.CLIENT_ADDED));
			var name:String = debugClient.getMetaDataType(MetaData.CLIENT_ADDED).data.client.name;
			Assert.assertEquals(name, DebugClient.NAME);
		}
		
		[Test]
		public function testGet_name():void
		{
			try{
				client.name;
			}catch(error:Error){
				Assert.assertTrue("Client threw expected error");
				return
			}
			Assert.fail("Client did not throw error");
		}
		
		[Test]
		public function testOnMetaData():void
		{
			broadcaster.addMetaData(new MetaData("TestMetaData"));
			Assert.assertNotNull(debugClient.getMetaDataType("TestMetaData"));
		}
		
		[Test]
		public function testRemoveBroadcaster():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.REMOVE_CLIENT, debugClient.name));
			Assert.assertNotNull(debugClient.getMetaDataType(MetaData.REMOVE_CLIENT));
			Assert.assertNotNull(debugClient.getMetaDataType(MetaData.CLIENT_REMOVED));
			broadcaster.addMetaData(new MetaData("TestMetaData"));
		}
		
		[Test]
		public function testCleanUp():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			Assert.assertNotNull(debugClient.getMetaDataType(MetaData.CLEAN_UP));
			Assert.assertNotNull(debugClient.getMetaDataType(MetaData.REMOVE_CLIENT));
			broadcaster.addMetaData(new MetaData("TestMetaData"));
			Assert.assertNull(debugClient.getMetaDataType("TestMetaData"));
		}		
	}
}