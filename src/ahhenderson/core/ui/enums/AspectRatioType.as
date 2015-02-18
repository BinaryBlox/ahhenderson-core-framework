package ahhenderson.core.ui.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;

	
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class AspectRatioType implements IEnumeration {

		/**
		 * 
		 * @default 
		 */
		public static const RATIO_DEFAULT:AspectRatioType = new AspectRatioType("RATIO_DEFAULT");
		
		public static const RATIO_4X3:AspectRatioType = new AspectRatioType("RATIO_4X3");
		
		public static const RATIO_16X9:AspectRatioType = new AspectRatioType("RATIO_16X9");
		
		public static const RATIO_16X10:AspectRatioType = new AspectRatioType("RATIO_16X10");
		
		 
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function AspectRatioType(value:String):void {
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
