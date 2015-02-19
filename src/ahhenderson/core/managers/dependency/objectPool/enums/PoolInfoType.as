
package ahhenderson.core.managers.dependency.objectPool.enums {
	
	public final class PoolInfoType {

		public static const POOL_SIZE:PoolInfoType = new PoolInfoType("POOL_SIZE");

		public static const POOL_UNUSED_OBJECTS:PoolInfoType = new PoolInfoType("POOL_UNUSED_OBJECTS");

		public static const POOL_USED_OBJECTS:PoolInfoType = new PoolInfoType("POOL_USED_OBJECTS");


		public static var list:Array = [POOL_SIZE.value,
			POOL_USED_OBJECTS.value,
			POOL_UNUSED_OBJECTS.value];

		private static var locked:Boolean = false;

		{
			locked = true;
		}


		public function PoolInfoType(PoolInfoType:String):void {
			if (locked) {
				throw new Error("You can't instantiate this class.");
			}
			_value = PoolInfoType;
		}


		private var _value:String;

		public function get value():String {
			return _value;
		}
	}
}
