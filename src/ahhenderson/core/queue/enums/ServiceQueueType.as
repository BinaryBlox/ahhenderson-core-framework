package ahhenderson.core.queue.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;

	
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class ServiceQueueType implements IEnumeration {

		/**
		 * 
		 * @default 
		 */
		public static const CONNECTION_TIMEOUT:ServiceQueueType = new ServiceQueueType("CONNECTION_TIMEOUT");
		 
		public static const POLLING_SERVICE:ServiceQueueType = new ServiceQueueType("POLLING_SERVICE");
		
		public static const PUSH_SERVICE:ServiceQueueType = new ServiceQueueType("PUSH_SERVICE");
		 
		/**
		 * 
		 * @PENDING_MESSAGE_TIMEOUT: Queue identifier for queue storing messages that require retry/fail logic 
		 */
		public static const PENDING_MESSAGE:ServiceQueueType = new ServiceQueueType("PENDING_MESSAGE_TIMEOUT");
		
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function ServiceQueueType(value:String):void {
			if (locked) {
				throw new Error("You can't instantiate another instance.");
			}
			_value = value;
		}

		private var _value:String;

		/**
		 * 
		 * @return 
		 */
		public function get value():String {
			return _value;
		}
	}
}
