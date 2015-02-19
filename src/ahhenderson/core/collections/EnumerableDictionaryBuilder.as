

package ahhenderson.core.collections {
	import mx.collections.ArrayList;
	
	import ahhenderson.core.collections.interfaces.IEnumerableDictionaryItem;
	import ahhenderson.core.collections.interfaces.IEnumeration;
	 
	public class EnumerableDictionaryBuilder  {
 
		
		/**
		 * Add a new item to the Custom Dictionary
		 *
		 * @dictionaryItem: IEnumerableDictionaryItem object 
		 * @dictionary: ArrayList of IEnumerableDictionaryItem items.
		 *
		 * Returns ArrayList
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function addItem(dictionaryItem:IEnumerableDictionaryItem, dictionary:ArrayList):ArrayList {
			 
			if(!dictionaryItem.key ){
				trace("Key or context was not provided...");
				return dictionary;
			}
			
			// Initialize dictionary if null
			if(!dictionary)
				dictionary = new ArrayList();
			
			
			var existingIndex:int=searchDictionary(dictionaryItem.keyAsEnum, dictionary);
			var bSuccess:Boolean;
			
			try {
				if (existingIndex >= 0) {
					
					if(dictionaryItem.isUpdateable){
						trace("Updating key: " + dictionaryItem.key); 
						dictionary.source[existingIndex]  = dictionaryItem;
					}
					
				} else {
					//trace("Registering key: " + dictionaryItem.key);
					dictionary.source.push(dictionaryItem);
				}
				
				return dictionary;
				 
			} catch (error:Error) {
				trace("Error attempting to register: " + error.message);
			}

			return null;
		}
		
		/**
		 * Searches for an existing item from the Custom Dictionary and returns the index found.
		 *
		 * @key: IEnumeration object 
		 * @dictionary: ArrayList of IEnumerableDictionaryItem items.
		 * 
		 * Returns Number
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function searchDictionary(key:IEnumeration, dictionary:ArrayList):Number {
			
			for (var i:int=0; i < dictionary.length; i++) { 
				var existingKey:String=IEnumerableDictionaryItem(dictionary.source[i]).key;
				
					 
				if (key.value == existingKey) {
					//trace("Found key: " + key);
					return i;
				}
			}
			
			return -1;
		}
		
		// Rebuilds array after removing existing item
		private static function rebuildVector(existingIndex:int, dictionary:ArrayList):ArrayList {
			
			var varr:ArrayList=new ArrayList();
			
			for (var i:int=0; i < dictionary.length; i++) {
				if (i != existingIndex)
					varr.source.push(dictionary.source[i]);
				
			}
			
			return varr;
		}
		
		/**
		 * Removes and existing item from the Custom Dictionary
		 *
		 * @key: IEnumeration object 
		 * @dictionary: ArrayList of IEnumerableDictionaryItem items.
		 * 
		 * Returns ArrayList
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function removeItem(key:IEnumeration, dictionary:ArrayList):ArrayList  {
			
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
				trace("Removing Session Member Error: " + error.message);
			}
 
			return null;
		}
		
		/**
		 * Gets item from the Custom Dictionary
		 *
		 * @key: IEnumeration object 
		 * @dictionary: ArrayList of IEnumerableDictionaryItem items.
		 * 
		 * Returns IEnumerableDictionaryItem
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function getItem(key:IEnumeration, dictionary:ArrayList):IEnumerableDictionaryItem {
			
			if (dictionary == null || dictionary.length == 0) {
				return null;
				trace("No keys have been registered...");
			}
			
			var item:IEnumerableDictionaryItem;
			
			for (var i:int=0;i<dictionary.length; i++) {
				
				if(dictionary.source[i] is IEnumerableDictionaryItem)
					item = dictionary.source[i] as IEnumerableDictionaryItem;
				
				var existingKey:String=item.key;
				if (key.value == existingKey) {
					//trace("Found registered session member " + key);					
					return item;
				}
			}
			 
			return null;
		}
		
		 
	}

}