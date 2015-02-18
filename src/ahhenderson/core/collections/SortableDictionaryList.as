package ahhenderson.core.collections
{
	
	import mx.collections.ArrayList;
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.collections.interfaces.ISortableDictionaryList;

	public class SortableDictionaryList implements ISortableDictionaryList
	{



		public function SortableDictionaryList()
		{

		}

		protected var _items:ArrayList;

		public function addItem(item:IDictionaryItem, ... args):Boolean
		{
			try
			{

				if (!item)
					return false;

				_items=SortableDictionaryBuilder.addItem(item, _items);

				return true

			}
			catch (e:Error)
			{
				return false;
			}

			return false;
		}

		public function getItem(key:String, ... args):*
		{
			try
			{
				return SortableDictionaryBuilder.getItem(key, _items);

			}
			catch (e:Error)
			{
				return null;
			}

			return null;
		}

		public function itemExists(key:String):Boolean
		{
			return searchDictionary(key, _items);
		}


		public function get items():ArrayList
		{
			if(!_items)
				_items = new ArrayList();
			
			return _items;
		}

		public function removeItem(key:String, ... args):void
		{
			var item:*=getItem(key);

			if (item)
			{
				// Remove any listners, etc.
			}

			_items=SortableDictionaryBuilder.removeItem(key, _items);

		}

		public function searchDictionary(key:String, dictionary:ArrayList):Boolean
		{
			if (!dictionary || dictionary.length == 0)
				return false;

			if (SortableDictionaryBuilder.searchDictionary(key, dictionary) >= 0)
				return true;

			return false;
		}
	}
}
