//------------------------------------------------------------------------------
//
//   Anthony Henderson  Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.queue.helpers {
	import ahhenderson.core.managers.ServiceQueueManager;
	import ahhenderson.core.queue.message.IMessageQueue;
	import ahhenderson.core.queue.message.MessageQueueItemSO;
	
	import ahhenderson.core.collections.interfaces.IEnumeration;


	public class ServiceQueueHpr {


		/**
		 *
		 * @param key - Unique key for the Queue (IEnumeration)
		 * @param defaultMessage - you can initialize the a new queue with a "looping message" that will continue
		 * forever until it is popped from the queue.
		 * @param pollingInterval - Polling frequency for the queue
		 * @param timeoutDuration- Message expiration
		 * @return
		 * @throws VzError
		 * @throws (error)
		 */
		public static function createQueue(key:IEnumeration, defaultMessage:MessageQueueItemSO = null, pollingInterval:int = 1000, timeoutDuration:int = 10000):Boolean {

			return ServiceQueueManager.instance.createQueue(key, defaultMessage, pollingInterval, timeoutDuration);
		}

		public static function disposeQueue(key:IEnumeration):void {
  
			ServiceQueueManager.instance.getQueue(key).dispose();
			ServiceQueueManager.instance.serviceQueueList.removeItem(key.value); 
			
			return;
		}

		public static function getQueue(key:IEnumeration):IMessageQueue {

			return ServiceQueueManager.instance.getQueue(key);
		}

		public static function queueExists(key:IEnumeration):Boolean {
			return ServiceQueueManager.instance.queueExists(key);
		}
	}
}
