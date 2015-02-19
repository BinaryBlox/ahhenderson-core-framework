
package ahhenderson.core.content.cache.helpers {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import ahhenderson.core.content.enums.MediaContentType;
	import ahhenderson.core.content.cache.cacheData.MediaCacheData;
	import ahhenderson.core.content.cache.ContentCache;


	/**
	 * 
	 * @author thenderson
	 */
	public class MediaCacheHpr {
		/**
		 * 
		 */
		public function MediaCacheHpr() {
		}

		private static const DEFAULT_IMAGE_CACHE_SIZE:int = 10;

		private static const DEFAULT_IMAGE_THUMB_CACHE_SIZE:int = 100;

		private static var _cacheAudio:ContentCache;

		private static var _cacheData:ContentCache;

		private static var _cacheImage:ContentCache;

		private static var _cacheImageThumb:ContentCache;

		/**
		 * 
		 * @param key
		 * @param type
		 * @param source
		 * @param data
		 * @param bitmapData
		 * @return 
		 */
		public static function addCacheItem(key:String, type:MediaContentType, source:String, bitmapData:BitmapData = null, data:ByteArray = null):Boolean {

			const isNewItem:Boolean = updateCache(new MediaCacheData(key, type, source, bitmapData, data));
				
			if(!isNewItem){
				//LogHpr.log(LType.INFO, LCategory.MEDIA_CACHE, "Item already in cache", "Item URL: " + key);
			}
			
			return isNewItem
		}

		/**
		 * 
		 * @param media
		 * @return 
		 */
		public static function addCacheItemAsObject(media:MediaCacheData):Boolean {

			return updateCache(media);
		}

		/**
		 * 
		 * @param key
		 * @param type
		 * @return 
		 */
		public static function cacheItemExists(key:String, type:MediaContentType):Boolean {

			switch (type) {

				case MediaContentType.MEDIA_TYPE__IMAGE:
					return cacheImage.itemExists(key);

				case MediaContentType.MEDIA_TYPE__IMAGE_THUMB:
					return cacheImageThumb.itemExists(key);

			}

			return false;
		}


		/**
		 * 
		 * @param key
		 * @param type
		 * @return 
		 */
		public static function getCacheItem(key:String, type:MediaContentType):MediaCacheData {

			switch (type) {

				case MediaContentType.MEDIA_TYPE__IMAGE:

					if (cacheImage.itemExists(key))
						return cacheImage.getQueueItem(key) as MediaCacheData;

					return null;

				case MediaContentType.MEDIA_TYPE__IMAGE_THUMB:
					if (cacheImageThumb.itemExists(key))
						return cacheImageThumb.getQueueItem(key) as MediaCacheData;

					return null;
			}

			return null;
		}

		private static function get cacheAudio():ContentCache {
			return _cacheAudio;
		}


		private static function get cacheData():ContentCache {
			return _cacheData;
		}

		private static function get cacheImage():ContentCache {

			if (!_cacheImage)
				_cacheImage = new ContentCache(DEFAULT_IMAGE_CACHE_SIZE);

			return _cacheImage;
		}

		private static function get cacheImageThumb():ContentCache {
			if (!_cacheImageThumb)
				_cacheImageThumb = new ContentCache(DEFAULT_IMAGE_THUMB_CACHE_SIZE);

			return _cacheImageThumb;
		}


		private static function checkQueueCapacity(queue:ContentCache):void {

			// If queue full, pop first item
			if (queue.size() > queue.defaultCapacity) {
				trace("queue reached - dequeuing");
				queue.dequeue();
			}
		}


		private static function searchCacheItem(data:MediaCacheData = null):MediaCacheData {

			if (!data)
				return null;

			switch (data.type) {

				case MediaContentType.MEDIA_TYPE__IMAGE:

					if (cacheImage.itemExists(data.key))
						return cacheImage.getQueueItem(data.key) as MediaCacheData;

					return null;

				case MediaContentType.MEDIA_TYPE__IMAGE_THUMB:
					if (cacheImageThumb.itemExists(data.key))
						return cacheImageThumb.getQueueItem(data.key) as MediaCacheData;

					return null;
			}

			return null;
		}

		private static function updateCache(data:MediaCacheData = null):Boolean {

			if (!data)
				return false;

			switch (data.type) {

				case MediaContentType.MEDIA_TYPE__IMAGE:

					if (cacheImage.itemExists(data.key))
						return false;

					checkQueueCapacity(cacheImage);

					//  Cache thumb
					cacheImageThumb.enqueue(data);

					return true;

				case MediaContentType.MEDIA_TYPE__IMAGE_THUMB:

					if (cacheImageThumb.itemExists(data.key))
						return false;

					checkQueueCapacity(cacheImageThumb);

					//  Cache thumb
					cacheImageThumb.enqueue(data);

					return true;
			}

			return false;
		}
	}
}
