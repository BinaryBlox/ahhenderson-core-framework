//------------------------------------------------------------------------------
//
//   ViziFit Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.collections.interfaces {

	public interface IDictionaryList extends IBaseDictionaryList {


		/**
		 * This function searches a Vector.<IDictionaryItem> collection for an IDictionaryItem.
		 *
		 *  @param key: unique id to validate it the item exists.
		 *  @param dictionary: Vector.<IDictionaryItem>.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		function searchDictionary(key:String, dictionary:Vector.<IDictionaryItem>):Boolean;
	}
}
