//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.content.cache.helpers {
    import ahhenderson.core.content.cache.enums.DataCacheType;
    import ahhenderson.core.content.cache.DataCache;
    import ahhenderson.core.content.cache.ContentCache;

    /**
     *
     * @author thenderson
     */
    public class DataCacheHpr {

        private static const DEFAULT_SESSION_CACHE_SIZE:int = 10;

        private static var _cacheSessionData:ContentCache;

        /**
         * 
         * @param key
         * @param type
         * @param data
         * @param args
         * @return 
         */
        public static function addCacheItem(key:String, type:DataCacheType, data:*, ... args):Boolean {

            const isNewItem:Boolean = updateCache(new DataCache(key, type, data));

           /* if (!isNewItem)
                LogHpr.log(LType.INFO, LCategory.DATA_STORE_CACHE, "Item already in cache", "Item key: " + key);*/

            return isNewItem
        }


        /**
         * 
         * @param data
         * @return 
         */
        public static function addCacheItemAsObject(data:DataCache):Boolean {

            return updateCache(data);
        }


        /**
         * 
         * @param key
         * @param type
         * @return 
         */
        public static function cacheItemExists(key:String, type:DataCacheType):Boolean {

            switch (type) {

                case DataCacheType.SESSION_DATA:
                    return cacheSessionData.itemExists(key);


            }

            return false;
        }


        /**
         * 
         * @param key
         * @param type
         * @return 
         */
        public static function getCacheItem(key:String, type:DataCacheType):DataCache {

            switch (type) {

                case DataCacheType.SESSION_DATA:

                    if (cacheSessionData.itemExists(key))
                        return cacheSessionData.getQueueItem(key) as DataCache;

                    return null;

            }

            return null;
        }




        private static function get cacheSessionData():ContentCache {

            if (!_cacheSessionData)
                _cacheSessionData = new ContentCache(DEFAULT_SESSION_CACHE_SIZE);

            return _cacheSessionData;
        }


        private static function checkQueueCapacity(queue:ContentCache):void {

            // If queue full, pop first item
            if (queue.size() > queue.defaultCapacity) {
                trace("queue reached - dequeuing");
                queue.dequeue();
            }
        }


        private static function searchCacheItem(data:DataCache = null):DataCache {

            if (!data)
                return null;

            switch (data.type) {

                case DataCacheType.SESSION_DATA:

                    if (cacheSessionData.itemExists(data.key))
                        return cacheSessionData.getQueueItem(data.key) as DataCache;

                    return null;


            }

            return null;
        }

        private static function updateCache(data:DataCache = null):Boolean {

            if (!data)
                return false;

            switch (data.type) {

                case DataCacheType.SESSION_DATA:

                    if (cacheSessionData.itemExists(data.key))
                        return false;

                    checkQueueCapacity(cacheSessionData);

                    //  Cache thumb
                    cacheSessionData.enqueue(data);

                    return true;
            }

            return false;
        }

        /**
         *
         */
        public function DataCacheHpr() {
        }
    }
}
