
package ahhenderson.core.collections {
	import mx.collections.ArrayCollection;
	
	import ahhenderson.core.collections.interfaces.IDictionaryItem;


	public class DictionaryList {
		public function DictionaryList() {
		}


		private var _items:Vector.<IDictionaryItem>;

		/**
		 *  Method addBaseItem has to be overriden and exposed publically through another method.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.5
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		public function addItem(item:IDictionaryItem, ... args):Boolean {
			try {

				if (!item)
					return false;

				_items = DictionaryBuilder.addItem(item, items);

				return true

			} catch (e:Error) {
				return false;
			}

			return false;
		}

		public function getItem(key:String, ... args):* {
			try {
				return DictionaryBuilder.getItem(key, items);

			} catch (e:Error) {
				return null;
			}

			return null;
		}
		
		public function toArray():Array{ 
			return DictionaryBuilder.toArray(items);
			
		}

		public function itemExists(key:String):Boolean {
			return searchDictionary(key, items);
		}

		public function get items():Vector.<IDictionaryItem> {
			if (!_items)
				_items = new Vector.<IDictionaryItem>();

			return _items;
		}

		public function set items(value:Vector.<IDictionaryItem>):void {
			_items = value;
		}

		public function purgeItems():Boolean {

			_items = null;

			return true;
		}

		public function removeItem(key:String, ... args):void {
			var item:* = getItem(key);

			if (item) {
				// Remove any listners, etc.
			}

			_items = DictionaryBuilder.removeItem(key, items);

		}

		public function getItemsAsArrayCollection():ArrayCollection{
			
			if(!_items){
				trace("getItemsAsArrayCollection: no items in DictionaryList");
				return null;
			}
			
			var returnArray:ArrayCollection = new ArrayCollection();
			
			for (var i:int=0;i<_items.length;i++){
				
				returnArray.addItem(_items[i]);
			}
			
			return returnArray;
		}
		
		public function searchDictionary(key:String, dictionary:Vector.<IDictionaryItem>):Boolean {
			if (!dictionary || dictionary.length == 0)
				return false;

			if (DictionaryBuilder.searchDictionary(key, dictionary) >= 0)
				return true;

			return false;
		}
	}
}
