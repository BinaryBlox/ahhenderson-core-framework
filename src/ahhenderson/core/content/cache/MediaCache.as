package ahhenderson.core.content.cache
{
	import ahhenderson.core.content.cache.cacheData.MediaCacheData;
	 
	 
	// This import is required for Flex 2
	//import flash.events.EventDispatcher;	
	
	
	public class MediaCache
		// To avoid binding warnings to "instance" in Flex 2 we need to
		// explicitly extends EventDispatcher and add  to the
		// static instance getter. 
		//extends EventDispatcher
	{
		
		
		/** Sample model property.  The name of the currently logged in user. */
		public var LocalCache:Vector.<MediaCacheData>; //for storing drop list data
		
		// =======================================
		//  Singleton instance
		// =======================================
		
		/** Storage for the singleton instance. */
		private static const _instance:MediaCache=new MediaCache(SingletonLock);
		
		/** Provides singleton access to the instance. */
		// We can use the Bindable metadata with an event name to prevent
		// Flex from reporting that "instance is not bindable".  We have to
		// use a custom event name because you cannot just use 
		// with a static function (it's a compiler error).
		//
		// Since we never actually change the instance, we never need to 
		// dispatch an event, so there is no negative side effects here.  If 
		// you're  getting warnings in the console log, try uncommenting the line
		// below.  This isn't necessary with recent Flex 3 builds, but it is for
		// Flex 2.
		//[Bindable( "instanceChange" )]
		public static function get instance():MediaCache
		{
			return _instance;
		}
		
		/**
		 * Constructor
		 *
		 * @param lock The Singleton lock class to pevent outside instantiation.
		 */
		public function MediaCache(lock:Class)
		{
			// Verify that the lock is the correct class reference.
			if (lock != SingletonLock)
			{
				throw new Error("Invalid Singleton access.  Use Model.instance.");
			}
			
			LocalCache=new Vector.<MediaCacheData>();
		}
		
		public  function searchFileCache(key:String):Number
		{
			for (var i:int=0; i < MediaCache.instance.LocalCache.length; i++)
			{
				if (key == MediaCache.instance.LocalCache[i].source)
				{
					trace("ImageCache - searching filename: " + key);
					return i;
				}
			}
			
			return -1;
		}
		
		public function getFileFromCache(key:String):MediaCacheData
		{
			var mediaData:MediaCacheData;
			
			if (MediaCache.instance.LocalCache == null || MediaCache.instance.LocalCache.length == 0)
			{
				return null;
				trace("file cache empty");
			}
			
			for (var i:int=0; i < MediaCache.instance.LocalCache.length; i++)
			{
				if (key == MediaCache.instance.LocalCache[i].source)
				{
					trace("ImageCache: getting filename: " + key);
					return MediaCache.instance.LocalCache[i];
				}
			}
			return null;
		}
		
		
		public function addFileToCache(data:MediaCacheData):Boolean
		{
			
			var existingIndex:int=searchFileCache(data.source);
			var bSuccess:Boolean;
			
			try
			{
				if (existingIndex >= 0)
				{
					MediaCache.instance.LocalCache[existingIndex]=data;
					trace("ImageCache - Replaced existing image: " + data.source);
				}
				else
				{
					trace("ImageCache - Added new image: " + data.source);
					MediaCache.instance.LocalCache.push(data);
				}
				
				bSuccess=true;
			}
			catch (error:Error)
			{
				throw new Error("Image cache failure " +  error.message);
				trace("ImageCache: " + error.message);
			}
			finally
			{
				return bSuccess;
			}
		}
		
	}
	
	
	// end class
} // end package

/**
 * This is a private class declared outside of the package
 * that is only accessible to classes inside of the Model.as
 * file.  Because of that, no outside code is able to get a
 * reference to this class to pass to the constructor, which
 * enables us to prevent outside instantiation.
 */
class SingletonLock
{
} // end class
