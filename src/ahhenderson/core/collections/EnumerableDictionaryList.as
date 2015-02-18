//------------------------------------------------------------------------------
//
//   ViziFit Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.collections {
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.collections.interfaces.IEnumerableDictionaryItem;
	import ahhenderson.core.collections.interfaces.IEnumerableDictionaryList;
	import ahhenderson.core.collections.interfaces.IEnumeration;
	import mx.collections.ArrayList;


	public class EnumerableDictionaryList implements IEnumerableDictionaryList {


		public function EnumerableDictionaryList() {

		}


		protected var _items:ArrayList;

		public function addItem(item:IEnumerableDictionaryItem, ... args):Boolean {
			try {

				if (!item)
					return false;

				_items = EnumerableDictionaryBuilder.addItem(item, _items);

				return true

			} catch (e:Error) {
				return false;
			}

			return false;
		}

		public function getItem(key:IEnumeration, ... args):* {
			try {
				return EnumerableDictionaryBuilder.getItem(key, _items);

			} catch (e:Error) {
				return null;
			}

			return null;
		}

		public function itemExists(key:IEnumeration):Boolean {
			return searchDictionary(key, _items);
		}


		public function get items():ArrayList {
			if (!_items)
				_items = new ArrayList();

			return _items;
		}

		public function removeItem(key:IEnumeration, ... args):void {
			var item:* = getItem(key);

			if (item) {
				// Remove any listners, etc.
			}

			_items = EnumerableDictionaryBuilder.removeItem(key, _items);

		}
		
		public function purgeItems():Boolean
		{
			
			_items=null;
			
			return true;
		}

		public function searchDictionary(key:IEnumeration, dictionary:ArrayList):Boolean {
			if (!dictionary || dictionary.length == 0)
				return false;

			if (EnumerableDictionaryBuilder.searchDictionary(key, dictionary) >= 0)
				return true;

			return false;
		}
	}
}
