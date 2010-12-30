package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.osas3cf.core.Broadcaster;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.data.metadata.TimerMetaData;
	import org.osas3cf.player.ChessTimer;

	public class ChessTimerTest
	{		
		private var timer:ChessTimer;
		private var broadcaster:Broadcaster;
		private var debugger:DebugClient;
		
		[Before]
		public function setUp():void
		{
			broadcaster = new Broadcaster();
			debugger = new DebugClient();
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(debugger)));
		}
		
		[After]
		public function tearDown():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.CLEAN_UP));
			broadcaster = null;
			debugger = null;
		}
		
		[Test]
		public function testTimerSetup():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(new ChessTimer(), {whitesTime:2, blacksTime:5})));
			broadcaster.addMetaData(new MetaData(MetaData.COMPLETE, "EndGame"));
			Assert.assertNotNull(debugger.getMetaDataType(TimerMetaData.TIMER_START));
			Assert.assertNotNull(debugger.getMetaDataType(TimerMetaData.NEW_TURN));
			Assert.assertEquals("White", debugger.getMetaDataType(TimerMetaData.NEW_TURN).data);
		}
		
		[Test]
		public function testTurnChange():void
		{
			broadcaster.addMetaData(new MetaData(MetaData.ADD_CLIENT, new ClientVO(new ChessTimer(), {turn: "Black",whitesTime:2, blacksTime:5})));
			broadcaster.addMetaData(new MetaData(MetaData.COMPLETE, "EndGame"));		
			Assert.assertNotNull(debugger.getMetaDataType(TimerMetaData.NEW_TURN));
			Assert.assertEquals("Black", debugger.getMetaDataType(TimerMetaData.NEW_TURN).data);
			broadcaster.addMetaData(new MetaData(MetaData.COMPLETE, "EndGame"));
			Assert.assertEquals("White", debugger.getMetaDataType(TimerMetaData.NEW_TURN).data);
		}
	}
}