//------------------------------------------------------------------------------
//
//   ViziFit Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------


package ahhenderson.core.collections.interfaces {
	
	import mx.collections.ArrayList;


	public interface IEnumerableDictionaryList  {

		
		/**
		 * This function adds an item from a Vector/ArrayList.
		 *
		 * @param item: IDictionaryItem to add
		 * @param args: rest arguments; might needs later.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		function addItem(item:IEnumerableDictionaryItem, ... args):Boolean;
		
		
		/**
		 * This function get's an IDictionaryItem from a Vector/ArrayList.
		 *
		 *  @param key: unique id to retrieve the item from the Vector/ArrayList
		 *  @param args: rest arguments; might needs later.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		function getItem(key:IEnumeration, ... args):*;
		
		/**
		 * This function checks if an item exists in a Vector/ArrayList.
		 *
		 * @param key: unique id to validate if the item exists.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		function itemExists(key:IEnumeration):Boolean;
		
		/**
		 * This function removes an item from a Vector/ArrayList.
		 *
		 * @param key: unique used to remove the item.
		 * @param args: rest arguments; might needs later.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		function removeItem(key:IEnumeration, ... args):void;
		
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
		function searchDictionary(key:IEnumeration, dictionary:ArrayList):Boolean;
		
		/**
		 * This removes all the items from the list
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		function purgeItems():Boolean;
		
	}
}
