package ahhenderson.core.interfaces {
	import starling.events.Event;
	
	/**
	 *
	 * @author tonyhenderson
	 */
	public interface IStarlingEventDispatcher {

		function addEventListener(type:String, listener:Function):void;
		
		function dispatchEvent(event:Event):void;

		function dispatchEventWith(type:String, bubbles:Boolean=false, data:Object=null):void;

		function hasEventListener(type:String):Boolean;

		function removeEventListener(type:String, listener:Function):void;

		function removeEventListeners(type:String=null):void
	}

}
