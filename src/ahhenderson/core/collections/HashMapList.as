//------------------------------------------------------------------------------
//
//   ViziFit Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.collections
{
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.collections.dependency.hashMapList.HashMap;

	public class HashMapList
	{
		public function HashMapList()
		{
		}

		public var _items:Vector.<IDictionaryItem>;

		/**
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 2.5
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		public function addItem(item:HashMap):Boolean
		{
			try
			{

				if (!item)
					return false;

				_items=DictionaryBuilder.addItem(item, items);

				return true

			}
			catch (e:Error)
			{
				return false;
			}

			return false;
		}

		public function toArray():Array{
			
			return DictionaryBuilder.toArray(items);
			
		}
		
		public function getItem(key:String):HashMap
		{
			try
			{
				return DictionaryBuilder.getItem(key, items) as HashMap;

			}
			catch (e:Error)
			{
				return null;
			}

			return null;
		}

		public function itemExists(key:String):Boolean
		{
			return searchDictionary(key, items);
		}
 
		public function get items():Vector.<IDictionaryItem>
		{
			if(!_items)
				_items = new Vector.<IDictionaryItem>();
			
			return _items;
		}

		public function purgeItems():Boolean
		{

			_items=null;

			return true;
		}

		public function removeItem(key:String):void
		{
			var item:*=getItem(key);

			if (item)
			{
				// Remove any listners, etc.
			}

			_items=DictionaryBuilder.removeItem(key, items);

		}

		private function searchDictionary(key:String, dictionary:Vector.<IDictionaryItem>):Boolean
		{
			if (!dictionary || dictionary.length == 0)
				return false;

			if (DictionaryBuilder.searchDictionary(key, dictionary) >= 0)
				return true;

			return false;
		}
	}
}
