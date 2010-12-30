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
package org.osas3cf.player
{
	import org.osas3cf.api.ClockEvent;
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.core.Client;
	import org.osas3cf.core.data.ClientVO;
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.data.metadata.TimerMetaData;
	import org.osas3cf.utility.Clock;
	import org.osas3cf.validation.EndGame;
	
	public class ChessTimer extends Client
	{
		public static const NAME:String = "Timer";
		
		private var clock:Clock;
		private var initTurn:String;
		
		public function ChessTimer(){}
		
		override public function onMetaData(metaData:MetaData):void
		{
			switch(metaData.type)
			{
				case MetaData.CLIENT_ADDED:
					var client:ClientVO = metaData.data as ClientVO
					if(client.client is ChessTimer)
					{
						var params:Object = client.params;
						clock = new Clock();
						clock.addEventListener(ClockEvent.TIMES_UP, handleTimesUp);
						clock.addEventListener(ClockEvent.NEW_TURN, handleNewTurn);
						clock.setTotalTime(params["whitesTime"], params["blacksTime"]);
						initTurn = params["turn"] ? params["turn"] : ChessPieces.WHITE;
						sendMetaData(new TimerMetaData(TimerMetaData.TIMER_START, clock));
					}
					break;
				case MetaData.COMPLETE:
					//Wait till the EndGame client is finished looking over the game to make sure 
					//the game is still going on.
					if(metaData.data == EndGame.NAME)
					{
						 if(clock.running)
							 clock.changeTurn();
						 else
							 clock.startClock(initTurn);
					}
					break;
				case MetaData.CLEAN_UP:
					clock.removeEventListener(ClockEvent.TIMES_UP, handleTimesUp);
					clock.removeEventListener(ClockEvent.NEW_TURN, handleNewTurn);
					clock.stop();
					clock = null;
					initTurn = null;
					break;
			}
		}
		
		private function handleTimesUp(event:ClockEvent):void
		{
			sendMetaData(new TimerMetaData(TimerMetaData.TIMER_END, event.data));
		}
		
		private function handleNewTurn(event:ClockEvent):void
		{
			sendMetaData(new TimerMetaData(TimerMetaData.NEW_TURN, event.data));
		}
		
		override public function get name():String{return NAME;}
	}
	
	
}