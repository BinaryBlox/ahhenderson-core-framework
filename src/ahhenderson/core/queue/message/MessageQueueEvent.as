//------------------------------------------------------------------------------
//
//   Anthony Henderson  
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.queue.message {
	import flash.events.Event;

	public class MessageQueueEvent extends Event {

		public static const ACTION__MESSAGE_FAILURE:String = "messageQueueMessageFailure";

		public static const ACTION__MESSAGE_RETRY:String = "messageQueueRetry";
		
		public static const ACTION__MESSAGE_RELOOP:String = "messageQueuePersistLoop";

		public static const MESSAGE_QUEUE_EVENT:String = "messageQueueEvent";

		public function MessageQueueEvent(type:String, action:String, messageQueueItem:MessageQueueItemSO = null, bubbles:Boolean = false, cancelable:Boolean = false) {

			super(type, bubbles, cancelable);

			this._messageQueueItem = messageQueueItem;
			this._action = action;

		}

		private var _action:String;

		private var _messageQueueItem:MessageQueueItemSO;

		public function get action():String {
			return _action;
		}

		public function get messageQueueItem():MessageQueueItemSO {
			return _messageQueueItem;
		}
	}
}
