

package ahhenderson.core.collections.interfaces {
	import mx.collections.ArrayList;


	public interface ISortableDictionaryList extends IBaseDictionaryList {

		/**
		 * This function searches a ArrayList for an IDictionaryItem.
		 *
		 *  @param key: unique id to validate it the item exists.
		 *  @param dictionary: ArrayList.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		function searchDictionary(key:String, dictionary:ArrayList):Boolean;
	}
}
