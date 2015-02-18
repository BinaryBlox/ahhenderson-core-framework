package ahhenderson.core.metrics {


	/**
	 *
	 * @author thenderson
	 */
	public final class WeightUnitType {

		/**
		 *
		 * @default
		 */
		public static const KG:WeightUnitType = new WeightUnitType( "Kilograms" );

		/**
		 *
		 * @default
		 */
		public static const LBS:WeightUnitType = new WeightUnitType( "Lbs" );

		/**
		 *
		 * @default
		 */
		public static const STONES:WeightUnitType = new WeightUnitType( "Stones" );

		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 *
		 * @param value
		 * @throws Error
		 */
		public function WeightUnitType( value:String ):void {

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
