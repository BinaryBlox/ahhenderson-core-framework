package ahhenderson.core.content.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;

	
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class MediaContentType implements IEnumeration {
 
		public static const MEDIA_TYPE__IMAGE:MediaContentType = new MediaContentType("MEDIA_TYPE__IMAGE");
		
		public static const MEDIA_TYPE__IMAGE_THUMB:MediaContentType = new MediaContentType("MEDIA_TYPE__IMAGE_THUMB");
		
		public static const MEDIA_TYPE__AUDIO:MediaContentType = new MediaContentType("MEDIA_TYPE__MUSIC");
		
		public static const MEDIA_TYPE__VIDEO:MediaContentType = new MediaContentType("MEDIA_TYPE__VIDEO");
		
		public static const MEDIA_TYPE__DOCUMENT:MediaContentType = new MediaContentType("MEDIA_TYPE__DOCUMENT");
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function MediaContentType(value:String):void {
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
