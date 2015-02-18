package ahhenderson.core.queue {
	import ahhenderson.core.queue.message.MessageQueueEvent;
	import ahhenderson.core.queue.message.MessageQueueItemSO;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	
	import ahhenderson.core.collections.DictionaryBuilder;
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	
	import org.osflash.signals.Signal;
	import ahhenderson.core.util.CustomTimer;

	public class MessageQueue extends EventDispatcher {

		public static const MSG_STATUS_NEW:String = "mqMessageStatusNew";
		
		public static const MSG_STATUS_LOOP:String = "mqMessageStatusLoop";

		public static const MSG_STATUS_PENDING:String = "mqMessageStatusPending";

		public static const MSG_STATUS_RETRY:String = "mqMessageStatusRetry";

		public static const ZERO_EXPIRATION:int = -1;
		
		public function MessageQueue(pollingInterval:int = 100, defaultTimeout:int = 1000) {
			_pollingInterval = pollingInterval;
			_defaultTimeout = defaultTimeout;
		}

		private var _defaultTimeout:int;

		private var _pollingInterval:int;

		private var m_messageExpiration:Number;

		private var m_messageQueueItems:Vector.<IDictionaryItem>;

		private var m_pollTime:Number;

		private var m_timer:CustomTimer;

		public function get onMessageQueueEvent():Signal
		{
			return _onMessageQueueEvent;
		}

		public function get defaultTimeout():int {
			return _defaultTimeout;
		}

		public function set defaultTimeout(value:int):void {
			_defaultTimeout = value;
		}

		public function get pollingInterval():int {
			return _pollingInterval;
		}

		public function set pollingInterval(value:int):void {
			_pollingInterval = value;
		}

		public function popMessage(key:String):void {
			removeItem(key);
		}

		public function pushMessage(messageQueueItem:MessageQueueItemSO):void {

			if (!messageQueueItem)
				return;

			// Message is already in the queue (ignore)
			if (messageQueueItem.status == MSG_STATUS_RETRY)
				return;

			// Change status & set timestamp
			messageQueueItem.status = MSG_STATUS_NEW;
			messageQueueItem.timeStamp = new Date();

			// Add item to queue.
			addItem(messageQueueItem);


		}

		private function addItem(item:IDictionaryItem, ... args):Boolean {
			try {

				if (!item)
					return false;

				m_messageQueueItems = DictionaryBuilder.addItem(item, m_messageQueueItems);

				// Since a message is going to be added to the queue
				// ensure polling.
				pollMessages();

				return true

			} catch (e:Error) {
				return false;
			}

			return false;
		}

		private function getItem(key:String, ... args):* {
			try {
				return DictionaryBuilder.getItem(key, m_messageQueueItems) as MessageQueueItemSO;

			} catch (e:Error) {
				return null;
			}

			return null;
		}
		
		protected var _onMessageQueueEvent:Signal = new Signal(MessageQueueEvent);

		public function itemExists(key:String):Boolean {
			return searchDictionary(key, m_messageQueueItems);
		}

		private function onPollInterval(e:TimerEvent):void {
 
			//trace("QUEUE Suspend Mode: " + AppMgr.def_I.suspendMode.value);
			
			// Pause queue if in suspend mode.
			/*if(AppMgr.instance.suspendMode == SuspendModeTypeEnum.ON){ 
				//LogHpr.log(LType.INFO, LCategory.SUSPEND_MODE, "Message Queue Suspended temporarily");
				return; 
			}*/

			if (!m_messageQueueItems || m_messageQueueItems.length == 0)
				stop();

			var messageQueueEvent:MessageQueueEvent;
			
			// Get current, polling time for comparison
			m_pollTime = new Date().time;

			// Loop through messages in Queue
			for each (var message:MessageQueueItemSO in m_messageQueueItems) {

				/*if(!message.lastRetry)
					message.lastRetry*/
				
				// If no expiration, send retry event an continue to next item.
				if(message.timeout == ZERO_EXPIRATION){
					
					messageQueueEvent = new MessageQueueEvent(MessageQueueEvent.MESSAGE_QUEUE_EVENT,
						MessageQueueEvent.ACTION__MESSAGE_RELOOP,
						message)
						
					// Support for standard event (eventually migrate)
					dispatchEvent(messageQueueEvent);
					
					// Support for Signal
					_onMessageQueueEvent.dispatch(messageQueueEvent)
					
					continue;
				}
					
				// Handle expiration time if stated.
				m_messageExpiration = message.timeStamp.time + message.timeout;

				//trace("Expiration: " + m_messageExpiration.toString());
				//trace("Current Time: " + m_pollTime.toString());
				if (m_messageExpiration <= m_pollTime) {

					messageQueueEvent = new MessageQueueEvent(MessageQueueEvent.MESSAGE_QUEUE_EVENT,
						MessageQueueEvent.ACTION__MESSAGE_FAILURE,
						message);
						
					// Support for standard event (eventually migrate)
					dispatchEvent(messageQueueEvent);
					
					// Support for Signal
					_onMessageQueueEvent.dispatch(messageQueueEvent);
					 
					// Remove key from Queue.	
					trace("Removed from queue: " + message.key);
					removeItem(message.key);
 
					/*trace("Expiration: " + String(message.timeStamp.time + message.timeout).toString());
					trace("Final Time: " + m_pollTime.toString());*/

				} else {

					// Send message retry event
					messageQueueEvent = new MessageQueueEvent(MessageQueueEvent.MESSAGE_QUEUE_EVENT,
						MessageQueueEvent.ACTION__MESSAGE_RETRY,
						message);
					
					// Support for standard event (eventually migrate)
					dispatchEvent(messageQueueEvent);
					
					// Support for Signal
					_onMessageQueueEvent.dispatch(messageQueueEvent);
				}
			}
		}

		private function pollMessages():void {
			if (!m_timer)
				m_timer = new CustomTimer(pollingInterval);


			if (!m_timer.running) {
				// Clear any previous event listeners.
				m_timer.removeEventListener(TimerEvent.TIMER, onPollInterval);

				// Prime
				m_timer.addEventListener(TimerEvent.TIMER, onPollInterval, false, 0, false);
				m_timer.start()

			}
		}

		private function removeItem(key:String, ... args):void {
			var item:MessageQueueItemSO = getItem(key);

			if (item) {
				// Remove any listners, etc.
			}

			m_messageQueueItems = DictionaryBuilder.removeItem(key, m_messageQueueItems);

		}

		private function searchDictionary(key:String, dictionary:Vector.<IDictionaryItem>):Boolean {
			if (!dictionary || dictionary.length == 0)
				return false;

			if (DictionaryBuilder.searchDictionary(key, dictionary) >= 0)
				return true;

			return false;
		}

		private function stop():void {

			if (m_timer) {
				m_timer.removeEventListener(TimerEvent.TIMER, onPollInterval);

				if (m_timer.running)
					m_timer.stop();

				m_timer = null
			}

		}
	}
}
