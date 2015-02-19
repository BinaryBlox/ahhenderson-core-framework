
package ahhenderson.core.managers.helpers {
	import ahhenderson.core.collections.interfaces.IEnumeration;
	import ahhenderson.core.managers.SessionManager;
	/**
	 *
	 * @author thenderson
	 */
	public class SessionHpr {

		
		/**
		 * Returns session member value or SessionMemberSO; if an error occurs an Error object will be returned.
		 *
		 * @key: Key of session member (String or IEnumeration ONLY)
		 * @returnSessionMemberSO: Return for SessionMemberSO
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function addProperty(key:*, context:*, contextType:String = null, isUpdateable:Boolean = true):Boolean {

			if (!(key is String) && !(key is IEnumeration)) {

				//throw new VzError(VzErrorCode.E2000_INVALID_PARAMETER_TYPE, "SessionHelper: addItem");

				return false;
			}

			const keyValue:String = (key is IEnumeration) ? IEnumeration(key).value : key;

			return SessionManager.instance.addProperty(keyValue, context, contextType, isUpdateable); 
		}

		
		/**
		 * Returns session member value or SessionMemberSO; if an error occurs an Error object will be returned.
		 *
		 * @key: Key of session member (String or IEnumeration ONLY)
		 * @returnSessionMemberSO: Return for SessionMemberSO
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function getProperty(key:*, returnSessionMemberSO:Boolean = false):* {
			if (!(key is String) && !(key is IEnumeration)) {
				//throw new VzError(VzErrorCode.E2000_INVALID_PARAMETER_TYPE, "SessionHelper: getItem");
				return false;
			}
			const keyValue:String = (key is IEnumeration) ? IEnumeration(key).value : key;
			
			return SessionManager.instance.getProperty(keyValue, returnSessionMemberSO);
		}
		
		
		/**
		 * Unregisters existing session member.
		 *
		 * @key: Key of session member (String or IEnumeration ONLY)
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function removeProperty(key:*):Boolean {
			if (!(key is String) || !(key is IEnumeration)) {
				//throw new VzError(VzErrorCode.E2000_INVALID_PARAMETER_TYPE, "SessionHelper: removeItem");
				return false;
			}
			const keyValue:String = (key is IEnumeration) ? IEnumeration(key).value : key;
			
			return SessionManager.instance.removeProperty(keyValue);
		}
	}
}
