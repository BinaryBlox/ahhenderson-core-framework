package ahhenderson.core.util {

	public class ValidationUtil {
		public function ValidationUtil() {
		}


		/**
		 *	Determines whether the specified string is an email.
		 *
		 *	@param p_string The string.
		 *
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function isEmail(p_string:String):Boolean {
			if (p_string == null) {
				return false;
			}
			var regx:RegExp=/^([a-zA-Z0-9]+[a-zA-Z0-9._%-]*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,4})$/;


			return regx.test(p_string);
		}


		/**
		 *	Determines whether the specified password is between 6-15 chars, one lower, one upper and one number.
		 *
		 *	@param p_string The string.
		 *
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function isPassword(p_string:String):Boolean {
			if (p_string == null) {
				return false;
			} 
			var regx:RegExp= new RegExp("^.*(?=.{6,15})(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).*$");
			 
			return regx.test(p_string);
		}

		/**
		 *	Determines whether two passwords match.
		 *
		 *	@param p_string1 The password.
		 *  @param p_string2 The password to match
		 * 
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function isPasswordMatch(p_string1:String, p_string2):Boolean {
			if (p_string1 == null || p_string2 == null) {
				return false;
			}

			if (p_string1 == p_string2)
				return true

			return false;

		}
	}
}
