//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.managers {
	import ahhenderson.core.collections.DictionaryList;
	import ahhenderson.core.collections.interfaces.IEnumeration;
	import ahhenderson.core.managers.base.AbstractServiceManager;
	import ahhenderson.core.queue.ServiceQueue;
	import ahhenderson.core.queue.message.IMessageQueue;
	import ahhenderson.core.queue.message.MessageQueueItemSO;

	/**
	 * 
	 * @author thenderson
	 */
	public class ServiceQueueManager extends AbstractServiceManager {


		/**
		 * Constructor
		 *
		 * @param lock The Singleton lock class to pevent outside instantiation.
		 */
		public function ServiceQueueManager(lock:Class) {
			// Verify that the lock is the correct class reference.
			if (lock != SingletonLock) {
				throw new Error("Invalid Singleton access.  Use Model.instance.");
			}
 
		}

		private static const _instance:ServiceQueueManager = new ServiceQueueManager(SingletonLock);

		/**
		 * 
		 * @return 
		 */
		public static function get instance():ServiceQueueManager {

			return _instance;
		}


		private var _serviceQueueList:DictionaryList
	    
		 
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
		public function createQueue(key:IEnumeration, defaultMessage:MessageQueueItemSO=null, pollingInterval:int = 1000, timeoutDuration:int = 10000):Boolean {

			var serviceQueue:IMessageQueue;
			
			try
			{
				if(serviceQueueList.itemExists(key.value)){
					/*LogHpr.log(LType.WARNING, LCategory.SERVICE_QUEUE, 
						"Service Queue already exists", 
						"The Service Queue with the key " + key.value + " already exists.")
						*/
						return false;
				}
				 
				// Add queue item
				serviceQueueList.addItem(new ServiceQueue(key, pollingInterval, timeoutDuration));
				
				/*LogHpr.log(LType.INFO, LCategory.SERVICE_QUEUE, 
					"Queue created", 
					"Queue created with id: " + key.value);*/
				
				if(defaultMessage){
					/*LogHpr.log(LType.INFO, LCategory.SERVICE_QUEUE, 
						"Default Queue Message added", 
						"Default message added for queue: " + key.value);*/
					
					// Push defalut messsage
					getQueue(key).pushMessage(defaultMessage); 
				}
				
				return true;
			} 
			catch(error:Error) 
			{
				throw(error);
				
				return false;
			}
			
			return false;
		}

		/**
		 * 
		 * @param type
		 * @return 
		 */
		public function getQueue(key:IEnumeration):IMessageQueue {
			return serviceQueueList.getItem(key.value) as IMessageQueue;
		}

		/**
		 * 
		 */
		override protected function initialize():void {

		}
		
		public function queueExists(key:IEnumeration):Boolean{
			return serviceQueueList.itemExists(key.value);
		}

		/**
		 * 
		 * @return 
		 */
		public function get serviceQueueList():DictionaryList {
			if (!_serviceQueueList)
				_serviceQueueList = new DictionaryList();

			return _serviceQueueList;
		}
	}
}

class SingletonLock {
}
