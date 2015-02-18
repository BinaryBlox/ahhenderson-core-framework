package ahhenderson.core.metrics
{
	/**
	 * 
	 * @author thenderson
	 */
	public final class HeightUnitType {
		
		/**
		 * 
		 * @default 
		 */
		public static const INCHES:HeightUnitType = new HeightUnitType( "Lbs" );
		
		/**
		 * 
		 * @default 
		 */
		public static const CENTIMETERS:HeightUnitType = new HeightUnitType( "Kilograms" );
		
		private static var locked:Boolean = false;
		
		{
			locked = true;
		}
		
		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function HeightUnitType( value:String ):void {
			
			if ( locked ) {
				throw new Error( "You can't instantiate another instance." );
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