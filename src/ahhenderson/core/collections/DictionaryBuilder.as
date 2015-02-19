
package ahhenderson.core.collections {
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	 
	public class DictionaryBuilder {

		/**
		 * Add a new item to the Custom Dictionary
		 *
		 * @dictionaryItem: IDictionaryItem object 
		 * @dictionary: Vector of IDictionary items.
		 *
		 * Returns Vector.<IDictionaryItem>
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function addItem(dictionaryItem:IDictionaryItem, dictionary:Vector.<IDictionaryItem>):Vector.<IDictionaryItem> {
			
			if(!dictionaryItem.key ){
				trace("Key or context was not provided...");
				return dictionary;
			}
			
			// Initialize dictionary if null
			if(!dictionary)
				dictionary = new Vector.<IDictionaryItem>();
			
			
			var existingIndex:int=searchDictionary(dictionaryItem.key, dictionary);
			var bSuccess:Boolean;
			
			try {
				if (existingIndex >= 0) {
					
					if(dictionaryItem.isUpdateable){
						//trace("Updating key: " + dictionaryItem.key); 
						dictionary[existingIndex]  = dictionaryItem;
					}
					
				} else {
					//trace("Registering key: " + dictionaryItem.key);
					dictionary.push(dictionaryItem);
				}
				
				return dictionary;
				 
			} catch (error:Error) {
				trace("Error attempting to register: " + error.message);
			}

			return null;
		}
		
		public static function searchDictionary(key:String, dictionary:Vector.<IDictionaryItem>):Number {
			
			for (var i:int=0; i < dictionary.length; i++) {
				
				if(!dictionary[i] || dictionary[i].key == null)
					continue;
				
				var existingKey:String=dictionary[i].key;
				
				if (key == existingKey) {
					//trace("Found key: " + key);
					return i;
				}
			}
			
			return -1;
		}
		
		public static function toArray( dictionary:Vector.<IDictionaryItem>):Array {
			
			var returnArray:Array = new Array(dictionary.length);
			
			for (var i:int=0; i < dictionary.length; i++)  
				returnArray.push(dictionary[i]); 
				  
			return returnArray;
		}
		
	
		
		// Rebuilds array after removing existing item
		private static function rebuildVector(existingIndex:int, dictionary:Vector.<IDictionaryItem>):Vector.<IDictionaryItem> {
			
			var varr:Vector.<IDictionaryItem>=new Vector.<IDictionaryItem>();
			
			for (var i:int=0; i < dictionary.length; i++) {
				if (i != existingIndex)
					varr.push(dictionary[i]);
				
			}
			
			return varr;
		}
		
		/**
		 * Removes and existing item from the Custom Dictionary
		 *
		 * @dictionaryItem: IDictionaryItem object 
		 * @dictionary: Vector of IDictionary items.
		 * 
		 * Returns Vector.<IDictionaryItem>
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function removeItem(key:String, dictionary:Vector.<IDictionaryItem>):Vector.<IDictionaryItem>  {
			
			// Initialize dictionary if null
			if(!dictionary)
				return null;
			
			var existingIndex:int=searchDictionary(key, dictionary);
			var bSuccess:Boolean;
			
			try {
				if (existingIndex >= 0) {
					return rebuildVector(existingIndex, dictionary);
					trace("Registered key removed.." + key);
					
				} else 
					trace("Registered key not found: " + key);
				  
			} catch (error:Error) {
				trace("Adding Session Member Error: " + error.message);
			}
 
			return null;
		}
		
		/**
		 * Gets item from the Custom Dictionary
		 *
		 * @dictionaryItem: IDictionaryItem object 
		 * @dictionary: Vector of IDictionary items.
		 * 
		 * Returns IDictionaryItem
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function getItem(key:String, dictionary:Vector.<IDictionaryItem>):IDictionaryItem {
			
			if (dictionary == null || dictionary.length == 0) {
				return null;
				trace("No keys have been registered...");
			}
			
			for each (var dictionaryItem:IDictionaryItem in dictionary) {
				
				var existingKey:String=dictionaryItem.key;
				if (key == existingKey) {
					//trace("Found registered session member " + key);					
					return dictionaryItem;
				}
			}
			 
			return null;
		}
		
		/*public static function addValue(key:String, value:*, dict:Dictionary):Boolean {

			if (!(searchDictionary(key, dict))) {
				dict[key]=value;
				return true;
			}

			return false;
		}

		public static function deleteValue(key:String, value:*, dict:Dictionary):Boolean {

			for (var value:* in dict) {
				trace(value + ' = ' + dict[value]);
				if (value == key) {
					delete dict[key];
					return true;
				}
			}

			return false;
		}

		public static function getValueFromDictionary(key:String, dict:Dictionary):* {

			return searchDictionary(key, dict);
		}


		public static function searchDictionary(key:String, dict:Dictionary):* {
			for (var value:* in dict) {
				trace(value + ' = ' + dict[value]);
				if (value == key)
					return value;
			}

			return null;
		}*/
	}

}