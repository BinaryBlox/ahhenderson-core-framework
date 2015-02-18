//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------


package ahhenderson.core.content.cache.cacheData {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import ahhenderson.core.content.enums.MediaContentType;
	import ahhenderson.core.content.cache.interfaces.ICacheData;


	/**
	 *
	 * @author Tony Henderson
	 */
	public class MediaCacheData implements ICacheData {


		/**
		 *
		 * @param key
		 * @param type
		 * @param source
		 * @param data
		 * @param bitmapData
		 * @param args
		 */
		public function MediaCacheData(key:String, type:MediaContentType, source:String = null, bitmapData:BitmapData = null, data:ByteArray = null, ... args) {

			this._key = key;
			this._type = type;
			this._source = source;
			this._data = data;
			this._bitmapData = bitmapData;
		}


		private var _args:Array;

		private var _bitmapData:BitmapData;

		private var _data:ByteArray;

		private var _key:String;

		private var _source:String;

		private var _type:MediaContentType;

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
		public function get bitmapData():BitmapData {
			return _bitmapData;
		}

		/**
		 *
		 * @return
		 */
		public function get data():ByteArray {
			return _data;
		}

		public function get isUpdateable():Boolean {
			return true;
		}

		public function get key():String {
			return _key;
		}


		/**
		 *
		 * @return
		 */
		public function get source():String {
			return _source;
		}

		/**
		 *
		 * @return
		 */
		public function get type():MediaContentType {
			return _type;
		}
	}

}

