//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------


package ahhenderson.core.content.cache {
	import ahhenderson.core.content.cache.enums.DataCacheType;
	
	import ahhenderson.core.collections.interfaces.IDictionaryItem;


	 
	/**
	 * 
	 * @author thenderson
	 */
	public class DataCache implements IDictionaryItem {

 
		/**
		 * 
		 * @param key
		 * @param type
		 * @param data
		 * @param args
		 */
		public function DataCache(key:String, type:DataCacheType, data:*, ... args) {

			this._key = key;
			this._type = type; 
			this._data = data; 
			this._args =args;
		}


		private var _args:Array;
 
		private var _data:*;

		private var _key:String; 

		private var _type:DataCacheType;
 
		/**
		 * 
		 * @return 
		 */
		public function get args():Array {
			return _args;
		}
 

		 
		/**
		 * 
		 * @return 
		 */
		public function get data():* {
			return _data;
		}

		/**
		 * 
		 * @return 
		 */
		public function get isUpdateable():Boolean {
			return true;
		}

		/**
		 * 
		 * @return 
		 */
		public function get key():String {
			return _key;
		}
  
		/**
		 * 
		 * @return 
		 */
		public function get type():DataCacheType {
			return _type;
		}
	}

}

