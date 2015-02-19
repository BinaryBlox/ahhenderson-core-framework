//------------------------------------------------------------------------------
//
//   Anthony Henderson  Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.queue {
	import ahhenderson.core.collections.interfaces.IEnumeration;
	import ahhenderson.core.queue.message.IMessageQueue;
	import ahhenderson.core.queue.message.MessageQueueEvent;
	import ahhenderson.core.queue.message.MessageQueueItemSO;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class ServiceQueue implements IMessageQueue {

		public function ServiceQueue(key:IEnumeration, pollingInterval:int = 100, defaultTimeout:int = 1000, isUpdateable:Boolean = false) {
			_pollingInterval = pollingInterval;
			_defaultTimeout = defaultTimeout;
			_key = key.value;
			_isUpdateable = isUpdateable;

			// Prime message queue
			_messageQueue = new MessageQueue(pollingInterval, defaultTimeout);
			_messageQueue.addEventListener(MessageQueueEvent.MESSAGE_QUEUE_EVENT, onInternalMessageQueueEvent);
		}


		protected var _isUpdateable:Boolean;

		protected var _key:String;

		protected var _onMessageReLoop:Signal = new Signal(MessageQueueEvent);

		protected var _onMessageRetry:Signal = new Signal(MessageQueueEvent);

		protected var _onMessageRetryFailed:Signal = new Signal(MessageQueueEvent);

		protected var _defaultTimeout:int;

		protected var _messageQueue:MessageQueue;

		protected var _pollingInterval:int;

		public function get defaultTimeout():int {
			return _defaultTimeout;
		}

		public function dispose():void {

			/*LogHpr.log(LType.INFO, LCategory.SERVICE_QUEUE,
				"Disposing service queue",
				"Disposing service queue with key: " + key);*/
			
			// Remove existing events
			onMessageRetryFailed.removeAll(); 
			onMessageReLoop.removeAll(); 
			onMessageRetry.removeAll(); 
			onMessageRetryFailed.removeAll();

			if (_messageQueue.hasEventListener(MessageQueueEvent.MESSAGE_QUEUE_EVENT))
				_messageQueue.removeEventListener(MessageQueueEvent.MESSAGE_QUEUE_EVENT, onInternalMessageQueueEvent);

			_messageQueue = null;
		}

		public function hasMessage(key:String):Boolean {
			return _messageQueue.itemExists(key);
		}

		public function initialize(queueItem:MessageQueueItemSO):void {
			pushMessage(queueItem);
		}

		public function get isUpdateable():Boolean {
			return _isUpdateable;
		}

		public function get key():String {
			return _key;
		}

		public function get onMessageReLoop():ISignal {
			return _onMessageReLoop;
		}

		public function get onMessageRetry():ISignal {
			return _onMessageRetry;
		}

		public function get onMessageRetryFailed():ISignal {
			return _onMessageRetryFailed;
		}

		public function get pollingInterval():int {
			return _pollingInterval;
		}

		public function popMessage(key:String):void {
			_messageQueue.popMessage(key);
		}

		public function pushMessage(queueItem:MessageQueueItemSO):void {

			// Push message in Queue to retry until timeout (if it is not already in the queue).
			if (!_messageQueue.itemExists(queueItem.key))
				_messageQueue.pushMessage(queueItem);
		}

		protected function onInternalMessageQueueEvent(e:MessageQueueEvent):void {

			switch (e.action) {
				case MessageQueueEvent.ACTION__MESSAGE_FAILURE:

					/*LogHpr.log(LType.WARNING,
						LCategory.MESSAGE_PUB_SUB,
						"Message TIMEOUT-FAILURE for:  " + e.messageQueueItem.key);
*/
					_onMessageRetryFailed.dispatch(e);

					break;

				case MessageQueueEvent.ACTION__MESSAGE_RETRY:

					/*LogHpr.log(LType.WARNING,
						LCategory.MESSAGE_PUB_SUB,
						"Message RETRY for:  " + e.messageQueueItem.key);
*/
					_onMessageRetry.dispatch(e);

					break;

				case MessageQueueEvent.ACTION__MESSAGE_RELOOP:

					/*LogHpr.log(LType.INFO,
						LCategory.REMOTE_MESSAGE_MGR,
						"Message RELOOP for:  " + e.messageQueueItem.key);
*/
					_onMessageReLoop.dispatch(e);

					break;
			}
		}
	}
}
