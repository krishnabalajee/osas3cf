package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	
	public class ClientTest
	{		
		private var client:Client;
		private var sampleClient:SampleClient;
		private var broadcaster:Broadcaster;
		
		[Before]
		public function setUp():void
		{
			client = new Client();
			sampleClient = new SampleClient();
			broadcaster = new Broadcaster();
		}
		
		[After]
		public function tearDown():void
		{
			client = null;
			sampleClient = null;
			broadcaster = null;
		}
		
		[Test]
		public function testAddBroadcaster():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(sampleClient)));
			Assert.assertTrue(sampleClient.added);
			broadcaster.addMetaData(new MetaData(MetaData.REMOVE_CLIENT, sampleClient.name));
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
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(sampleClient)));
			broadcaster.addMetaData(new MetaData("TestMetaData"));
			Assert.assertTrue(sampleClient.recieveMetaData);
			broadcaster.addMetaData(new MetaData(MetaData.REMOVE_CLIENT, sampleClient.name));
		}
		
		[Test]
		public function testRemoveBroadcaster():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(sampleClient)));
			broadcaster.addMetaData(new MetaData(MetaData.REMOVE_CLIENT, sampleClient.name));
			Assert.assertTrue(sampleClient.removed);
			broadcaster.addMetaData(new MetaData("TestMetaData"));
			Assert.assertFalse(sampleClient.recieveMetaData);
		}
		
		[Test]
		public function testCleanUp():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(sampleClient)));
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			Assert.assertTrue(sampleClient.removed);
			broadcaster.addMetaData(new MetaData("TestMetaData"));
			Assert.assertFalse(sampleClient.recieveMetaData);
		}		
	}
}