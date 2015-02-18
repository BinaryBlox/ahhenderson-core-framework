package ahhenderson.core.content.cache.enums {
	import ahhenderson.core.collections.interfaces.IEnumeration;

	
	/**
	 * 
	 * @author tonyhenderson
	 */
	public final class MediaCacheType implements IEnumeration {

	 
		public static const IMAGE_CACHE__CONTROL:MediaCacheType = new MediaCacheType("IMAGE_CACHE__CONTROL");
		
		public static const IMAGE_CACHE__THUMBNAIL:MediaCacheType = new MediaCacheType("IMAGE_CACHE__THUMBNAIL");
		
		public static const IMAGE_CACHE__LARGE_IMAGE:MediaCacheType = new MediaCacheType("IMAGE_CACHE__LARGE_IMAGE");
		
		public static const IMAGE_CACHE__TEXTURE:MediaCacheType = new MediaCacheType("IMAGE_CACHE__TEXTURE");
		
		private static var locked:Boolean = false;

		{
			locked = true;
		}

		/**
		 * 
		 * @param value
		 * @throws Error
		 */
		public function MediaCacheType(value:String):void {
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
