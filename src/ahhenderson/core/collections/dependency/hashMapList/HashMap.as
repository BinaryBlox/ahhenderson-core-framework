//------------------------------------------------------------------------------
//
//   ViziFit Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.collections.dependency.hashMapList
{
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	public class HashMap implements IDictionaryItem
	{
		
		public function HashMap(key:String, value:*, isUpdateable:Boolean=true)
		{
			this._key = key;
			this._value = value;
			this._isUpdateable = isUpdateable;
			
			
		}

		
		private var _isUpdateable:Boolean;
		
		private var _key:String;

		private var _value:*;

		public function get isUpdateable():Boolean
		{
			return _isUpdateable;
		}
		
		public function get key():String
		{
			return _key;
		}
		
		public function get value():*
		{
			return _value;
		}
	}
}