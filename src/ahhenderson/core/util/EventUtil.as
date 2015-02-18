//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.util {
	import flash.events.TimerEvent;
	
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class EventUtil {
 
		 
		private static function onDelayMessageComplete(e:TimerEvent):void {
			
			if(!(e.currentTarget is CustomTimer))
				return;
				
			var delayTimer:CustomTimer = e.currentTarget as CustomTimer;
			
			if (delayTimer.TimerData is Object){ 
				const delayedEvent:Event =  delayTimer.TimerData.event as Event; 
				
				// Dispatch
				DisplayObject(delayTimer.TimerData.component).dispatchEventWith(delayedEvent.type, delayedEvent.bubbles, delayedEvent.data) 
			}
				  
			delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onDelayMessageComplete); 
			delayTimer = null;
		}
		public static function dispatchDelayedEvent(delay:int, displayObject:DisplayObject, type:String, bubbles:Boolean=false, data:Object=null):void {
 
			var delayTimer:CustomTimer = new CustomTimer(delay, 1);
			delayTimer.TimerData = new Object();
			
			delayTimer.TimerData.event = new Event(type, bubbles, data);
			delayTimer.TimerData.component = displayObject;
			delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayMessageComplete, false, 0, true);
			delayTimer.start();
		} 
	}
}
