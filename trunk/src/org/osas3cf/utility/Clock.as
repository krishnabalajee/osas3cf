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
package org.osas3cf.utility
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osas3cf.api.IClock;
	import org.osas3cf.board.ChessPieces;
	import org.osas3cf.events.ClockEvent;
	
	public class Clock extends Timer implements IClock
	{
		private var _time:int = 0;
		private var _blackTime:int = 0;
		private var _whiteTime:int = 0;
		private var _whiteTotalTime:Number = -1;
		private var _blackTotalTime:Number = -1;
		
		private var whitesTurn:Boolean = true;
		
		public function Clock()
		{
			super(1000);
		}
		
		public function startClock(color:String = "White"):void
		{
			whitesTurn  = (color ==  ChessPieces.WHITE) ? true : false;
			dispatchEvent(new ClockEvent(ClockEvent.NEW_TURN, color));
			start();
		}
		
		override public function start():void
		{
			addEventListener(TimerEvent.TIMER, handleTimer);
			addEventListener(ClockEvent.TIMES_UP, handleTimesUp);
			super.start();
		}
		
		override public function stop():void
		{
			removeEventListener(TimerEvent.TIMER, handleTimer);
			removeEventListener(ClockEvent.TIMES_UP, handleTimesUp);
			_time = 0;
			_blackTime = 0;
			_whiteTime = 0;
			_whiteTotalTime = -1;
			_blackTotalTime = -1;
			whitesTurn = true;
			super.stop();
		}
		
		public function setTotalTime(white:Number = -1, black:Number = -1):void
		{
			CONFIG::debug{Debug.out("white total time: "+white+", black total time: " + black,this)}
			_whiteTotalTime = white;
			_blackTotalTime = black;
		}
		
		/**
		 * @private
		 **/
		public function changeTurn():void
		{
			whitesTurn = whitesTurn ? false : true;
			var color:String = whitesTurn ? ChessPieces.WHITE : ChessPieces.BLACK;
			dispatchEvent(new ClockEvent(ClockEvent.NEW_TURN, color));
		}
		
		public function get whiteTime():int{return _whiteTime;}
		public function get blackTime():int{return _blackTime;}
		public function get whiteTotalTime():int {return _whiteTotalTime;}
		public function get blackTotalTime():int {return _blackTotalTime;}
		public function get time():int{return _time;}
		
		private function handleTimer(event:TimerEvent):void
		{
			_time ++;
			if(whitesTurn){
				_whiteTime ++;
				if(_whiteTotalTime != -1)
				{
					_whiteTotalTime --;
					if(_whiteTotalTime <= 0)
						dispatchEvent(new ClockEvent(ClockEvent.TIMES_UP, ChessPieces.WHITE));	
				}
			}else{
				_blackTime ++;
				if(_blackTotalTime != -1)
				{
					_blackTotalTime --;
					if(_blackTotalTime <= 0)
						dispatchEvent(new ClockEvent(ClockEvent.TIMES_UP, ChessPieces.BLACK));
				}
			}
		}
		
		private function handleTimesUp(event:ClockEvent):void
		{
			stop();
		}
	}
}