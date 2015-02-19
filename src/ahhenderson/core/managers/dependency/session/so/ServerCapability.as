
package ahhenderson.core.managers.dependency.session.so{
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	
	public class ServerCapability implements IDictionaryItem {
		
		public function ServerCapability(key:String, 
										 value:*=null,
										 valueType:String=null,
										 isUpdateable:Boolean=true ) {
			
			this._key=key;  
			this._value=value; 
			this._isUpdateable=isUpdateable; 
			 
		}
		
		 
		private var _isUpdateable:Boolean;
		
		private var _key:String;
		
		private var _value:*;
		
		  
	 
		public function get value():*
		{
			return _value;
		}

		public function get isUpdateable():Boolean {
			return _isUpdateable;
		}
		
		public function get key():String {
			return _key;
		}
	  
	}
}

