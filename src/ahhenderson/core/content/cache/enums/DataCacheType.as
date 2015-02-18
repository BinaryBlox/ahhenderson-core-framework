package ahhenderson.core.content.cache.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;

	
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class DataCacheType implements IEnumeration {
 
		public static const SYSTEM_DATA:DataCacheType = new DataCacheType("SYSTEM_DATA");
		
		public static const PRIVATE_DATA:DataCacheType = new DataCacheType("PRIVATE_DATA");
		
		public static const SETTINGS_DATA:DataCacheType = new DataCacheType("SETTINGS_DATA");
		
		public static const SESSION_DATA:DataCacheType = new DataCacheType("SESSION_DATA");
		
	  
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function DataCacheType(value:String):void {
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
