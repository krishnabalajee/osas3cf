package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	import org.osas3cf.api.ClockEvent;
	import org.osas3cf.utility.Clock;

	public class ClockTest
	{		
		[Test(async,timeout="5000")]
		public function testTimesUp():void
		{
			var clock:Clock = new Clock();
			clock.addEventListener(ClockEvent.TIMES_UP, Async.asyncHandler(this, handleTimesUp, 5000));
			clock.setTotalTime(2, 10);
			clock.startClock();
		}
		
		[Test(async,timeout="500")]
		public function testTurnChange():void
		{
			var clock:Clock = new Clock();
			clock.startClock();
			clock.addEventListener(ClockEvent.NEW_TURN, Async.asyncHandler(this,  handleNewTurn, 500));
			clock.changeTurn();
		}
		
		private function handleTimesUp(event:ClockEvent, passThroughData:Object):void
		{
			Assert.assertEquals(event.target.time, 2);
			Assert.assertEquals(event.target.whiteTime, 2);
			Assert.assertEquals(event.target.blackTime, 0);
			Assert.assertEquals(event.type, ClockEvent.TIMES_UP);
			Assert.assertEquals(event.data, "White");
			event.target.stop();
		}
		
		private function handleNewTurn(event:ClockEvent, passThroughData:Object):void
		{
			Assert.assertEquals(event.type, ClockEvent.NEW_TURN);
			Assert.assertEquals(event.data, "Black");
			event.target.stop();
		}
		
	}
}