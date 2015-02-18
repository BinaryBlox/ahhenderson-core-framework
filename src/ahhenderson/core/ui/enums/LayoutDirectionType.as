
package ahhenderson.core.ui.enums {

	import ahhenderson.core.collections.interfaces.IEnumeration;


	public final class LayoutDirectionType implements IEnumeration {

		public static const LEFT:LayoutDirectionType = new LayoutDirectionType( "LEFT" );

		public static const RIGHT:LayoutDirectionType = new LayoutDirectionType( "RIGHT" );

		public static const TOP:LayoutDirectionType = new LayoutDirectionType( "TOP" );

		public static const BOTTOM:LayoutDirectionType = new LayoutDirectionType( "BOTTOM" );

		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 *
		 * @param value
		 * @throws Error
		 */
		public function LayoutDirectionType( value:String ):void {

			if ( locked ) {
				throw new Error( "You can't instantiate another instance." );
			}
			_value = value;

		}

		private var _value:String;

		public function get value():String {

			return _value;
		}
	}
}
