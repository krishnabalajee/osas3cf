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
		private var sampleClient:DebugClient;
		private var broadcaster:Broadcaster;
		
		[Before]
		public function setUp():void
		{
			client = new Client();
			sampleClient = new DebugClient();
			broadcaster = new Broadcaster();
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(sampleClient)));
		}
		
		[After]
		public function tearDown():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			client = null;
			sampleClient = null;
			broadcaster = null;
		}
		
		[Test]
		public function testAddBroadcaster():void
		{
			Assert.assertNotNull(sampleClient.getMetaDataType(MetaData.CLIENT_ADDED));
		}
		
		[Test]
		public function testGet_name():void
		{
			try{
				client.name;
			}catch(error:Error){
				Assert.assertTrue(true);
				return
			}
			Assert.fail("Client did not throw error");
		}
		
		[Test]
		public function testOnMetaData():void
		{
			broadcaster.addMetaData(new MetaData("TestMetaData"));
			Assert.assertNotNull(sampleClient.getMetaDataType("TestMetaData"));
		}
		
		[Test]
		public function testRemoveBroadcaster():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.REMOVE_CLIENT, sampleClient.name));
			Assert.assertNotNull(sampleClient.getMetaDataType(MetaData.REMOVE_CLIENT));
			Assert.assertNotNull(sampleClient.getMetaDataType(MetaData.CLIENT_REMOVED));
			broadcaster.addMetaData(new MetaData("TestMetaData"));
			Assert.assertNull(sampleClient.getMetaDataType("TestMetaData"));
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(sampleClient)));
		}
		
		[Test]
		public function testCleanUp():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			Assert.assertNotNull(sampleClient.getMetaDataType(MetaData.CLEAN_UP));
			Assert.assertNotNull(sampleClient.getMetaDataType(MetaData.REMOVE_CLIENT));
			broadcaster.addMetaData(new MetaData("TestMetaData"));
			Assert.assertNull(sampleClient.getMetaDataType("TestMetaData"));

			sampleClient = new DebugClient();
			broadcaster = new Broadcaster();
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(sampleClient)));
		}		
	}
}