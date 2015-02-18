//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.util.dependency.arg {
	import ahhenderson.core.collections.interfaces.IDictionaryItem;

	public class Arg implements IDictionaryItem  {
		
		public function Arg(key:String, value:*, defaultValue:*=null, isUpdateable:Boolean=true)
		{
			this._key = key;
			this._value = value;
			this._isUpdateable = isUpdateable;
			this._defaultValue = defaultValue;
			 
		}
		
		private var _defaultValue:*;
		
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
			// Attempt to return default if not available.
			if(!_value)
				return _defaultValue;
			
			return _value;
		}
	}
}
