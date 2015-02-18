package ahhenderson.core.managers
{
	import ahhenderson.core.managers.dependency.device.enums.SuspendModeTypeEnum;
	 
	public class DeviceManager
	{
		 
		
		private static const _instance:DeviceManager = new DeviceManager(SingletonLock);

		
		public static function get instance():DeviceManager {
			
			return _instance;
		}
		
		private var _suspendMode:SuspendModeTypeEnum;
		
		public function get suspendMode():SuspendModeTypeEnum {
			return _suspendMode;
		}
		
		public function set suspendMode(value:SuspendModeTypeEnum):void {
			_suspendMode = value;
		}
		
		/**
		 * Constructor
		 *
		 * @param lock The Singleton lock class to pevent outside instantiation.
		 */
		public function DeviceManager(lock:Class) {
			// Verify that the lock is the correct class reference.
			if (lock != SingletonLock) {
				throw new Error("Invalid Singleton access.  Use Model.instance.");
			} 
			
			// Create initial pools of commonly used objects
			 
		}
		
		

	}
}

class SingletonLock {
}