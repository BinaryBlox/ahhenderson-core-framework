//------------------------------------------------------------------------------
//
//   Anthony Henderson  
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

/**
 * File: ArrayHelper.as
 * @Author: Tony Henderson
 * Purpose:

 */

package ahhenderson.core.util {
	import flash.utils.describeType;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import ahhenderson.core.managers.LoggingManager;

	/**
	 *
	 * @author thenderson
	 */
	public class ArrayUtil {

		/**
		 * 
		 * @param searchProperty
		 * @param matchValue
		 * @param addValue
		 * @param targetArray
		 * @return 
		 */
		public static function addUnTypedObjectToArray( searchProperty:String, matchValue:String, addValue:Object, targetArray:Array ):Array {

			var keyValue:String = new String();

			for each ( var obj:Object in targetArray ) {
				keyValue = ObjectUtil.getValueFromUnTypedObject( searchProperty, obj );

				// Don't add if object exists.
				if ( keyValue == matchValue ) {
					return null;
				}
			}

			// Add new object to Array
			targetArray.push( addValue );

			return targetArray;

		}

		/**
		 *
		 * @param aArray
		 * @return
		 */
		public static function average( aArray:Array ):Number {

			return sum( aArray ) / aArray.length;
		}

		/**
		 *
		 * @param array
		 * @param sortField
		 * @param doReverseSort
		 * @return
		 */
		public static function convertArrayToArrayCollection( array:Array, sortField:String = null, doReverseSort:Boolean =
			false ):ArrayCollection {

			var arrColl:ArrayCollection = new ArrayCollection();

			for ( var i:int = 0; i < array.length; i++ )
				arrColl.addItem( array[ i ]);

			if ( sortField != null ) {
				var itemSort:Sort = new Sort();
				var sortFieldFilter:SortField = new SortField( sortField, false, doReverseSort );
				itemSort.fields = [ sortFieldFilter ];
				arrColl.sort = itemSort;
				arrColl.refresh();
			}

			return arrColl;

		}

		/**
		 * 
		 * @param searchProperty
		 * @param matchValues
		 * @param targetArray
		 * @return 
		 */
		public static function deleteMultipleUnTypedObjectFromArray( searchProperty:String, matchValues:Array, targetArray:Array ):Array {

			var keyValue:String = new String();

			if ( targetArray == null || targetArray.length == 0 ) {
				return targetArray;
			}

			for each ( var itemDeleteKey:String in matchValues ) {

				targetArray = deleteUnTypedObjectFromArray( searchProperty, itemDeleteKey, targetArray );
			}

			return targetArray;

		}

		/**
		 * 
		 * @param searchProperty
		 * @param matchValue
		 * @param targetArray
		 * @return 
		 */
		public static function deleteUnTypedObjectFromArray( searchProperty:String, matchValue:String, targetArray:Array ):Array {

			var keyValue:String = new String();

			if ( targetArray == null || targetArray.length == 0 ) {
				return targetArray;
			}

			for ( var i:int = 0; i < targetArray.length; i++ ) {
				keyValue = ObjectUtil.getValueFromUnTypedObject( searchProperty, targetArray[ i ]);

				if ( keyValue == matchValue ) {
					targetArray.splice( i, 1 );
					return targetArray;
				}

			}

			return targetArray;

		}

		/**
		 *
		 * @param oArray
		 * @param bRecursive
		 * @return
		 */
		public static function duplicate( oArray:Object, bRecursive:Boolean = false ):Object {

			var oDuplicate:Object;
			var sItem:String;

			if ( bRecursive ) {
				if ( oArray is Array ) {
					oDuplicate = new Array();

					for ( var i:Number = 0; i < oArray.length; i++ ) {
						if ( oArray[ i ] is Object ) {
							oDuplicate[ i ] = duplicate( oArray[ i ]);
						} else {
							oDuplicate[ i ] = oArray[ i ];
						}
					}
					return oDuplicate;
				} else {
					oDuplicate = new Object();

					for ( sItem in oArray ) {
						if ( oArray[ sItem ] is Object && !( oArray[ sItem ] is String ) && !( oArray[ sItem ] is Boolean ) &&
							!( oArray[ sItem ] is Number )) {
							oDuplicate[ sItem ] = duplicate( oArray[ sItem ], bRecursive );
						} else {
							oDuplicate[ sItem ] = oArray[ sItem ];
						}
					}
					return oDuplicate;
				}
			} else {
				if ( oArray is Array ) {
					return oArray.concat();
				} else {
					oDuplicate = new Object();

					for ( sItem in oArray ) {
						oDuplicate[ sItem ] = oArray[ sItem ];
					}
					return oDuplicate;
				}
			}
		}

		/**
		 *
		 * @param aArrayA
		 * @param aArrayB
		 * @param bNotOrdered
		 * @param bRecursive
		 * @return
		 */
		public static function equals( aArrayA:Array, aArrayB:Array, bNotOrdered:Boolean, bRecursive:Boolean ):Boolean {

			if ( aArrayA.length != aArrayB.length ) {
				return false;
			}
			var aArrayACopy:Array = aArrayA.concat();
			var aArrayBCopy:Array = aArrayB.concat();

			if ( bNotOrdered ) {
				aArrayACopy.sort();
				aArrayBCopy.sort();
			}

			for ( var i:Number = 0; i < aArrayACopy.length; i++ ) {
				if ( aArrayACopy[ i ] is Array && bRecursive ) {
					if ( !equals( aArrayACopy[ i ], aArrayBCopy[ i ], bNotOrdered, bRecursive )) {
						return false;
					}
				} else if ( aArrayACopy[ i ] is Object && bRecursive ) {
					if ( !objectEquals( aArrayACopy[ i ], aArrayBCopy[ i ])) {
						return false;
					}
				} else if ( aArrayACopy[ i ] != aArrayBCopy[ i ]) {
					return false;
				}
			}
			return true;
		}

		/**
		 *	Returns an array of values for a specified property in an object.
		 *
		 *	@param targetProperty The property to extract the values from.
		 *	@param data The data collection of objects (typed or untyped)
		 *  @param uniqueValues Only return unique values (true by default)
		 *
		 *	@returns ArrayCollection
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function extractPropertyValuesFromCollection( targetProperty:String, data:ArrayCollection, uniqueValues:Boolean =
			true ):ArrayCollection {

			var uniqueCollection:ArrayCollection = new ArrayCollection();
			var sourceValue:String;
			var i:int;
			var accList:XMLList;
			var varList:XMLList;
			var sourceObj:*;

			// loop through untyped objects
			for ( i = 0; i < data.length; i++ ) {
				sourceValue = ObjectUtil.getValueFromUnTypedObject( targetProperty, data[ i ]);

				if ( uniqueValues ) {
					if ( uniqueCollection.contains( sourceValue ))
						continue;

				}

				// item to return
				if ( sourceValue )
					uniqueCollection.addItem( sourceValue );
			}

			// loop typed objects
			for ( i = 0; i < data.length; i++ ) {
				sourceObj = data[ i ];

				if ( !accList )
					accList = flash.utils.describeType( sourceObj )..accessor;

				if ( !varList )
					varList = flash.utils.describeType( sourceObj )..variable;

				sourceValue = ObjectUtil.getValueFromTypedObject( targetProperty, sourceObj, accList, varList );

				if ( uniqueValues ) {
					if ( uniqueCollection.contains( sourceValue ))
						continue;

				}

				// item to return 
				if ( sourceValue )
					uniqueCollection.addItem( sourceValue );
			}

			return uniqueCollection;
		}

		/**
		 * 
		 * @param searchProperty
		 * @param value
		 * @param arr
		 * @return 
		 */
		public static function filterArrayByInt( searchProperty:String, value:int, arr:Array ):Array {

			var obj:Object = new Object();
			obj.value = value;

			var filterFunction:Function = function( element:*, index:int, arr:Array ):Boolean {

				return element[ searchProperty ] == this.value;
			}

			return arr.filter( filterFunction, obj );
		}

		/**
		 * 
		 * @param searchProperty
		 * @param values
		 * @param arr
		 * @return 
		 */
		public static function filterArrayByIntValues( searchProperty:String, values:Array, arr:Array ):Array {

			var obj:Object = new Object();
			obj.values = values;

			if ( !values || values.length == 0 )
				return null;

			var filterFunction:Function = function( element:*, index:int, arr:Array ):Boolean {

				for ( var i:int = 0; i < this.values.length; i++ ) {
					if ( element[ searchProperty ] == this.values[ i ])
						return true;
				}

				return false;
			}

			return arr.filter( filterFunction, obj );
		}

		/**
		 * 
		 * @param searchProperty
		 * @param value
		 * @param arr
		 * @return 
		 */
		public static function filterArrayByString( searchProperty:String, value:String, arr:Array ):Array {

			var obj:Object = new Object();
			obj.value = value;

			var filterFunction:Function = function( element:*, index:int, arr:Array ):Boolean {

				return element[ searchProperty ] == this.value;
			}

			return arr.filter( filterFunction, obj );
		}

		/**
		 * 
		 * @param searchProperty
		 * @param values
		 * @param arr
		 * @return 
		 */
		public static function filterArrayByStringValues( searchProperty:String, values:Array, arr:Array ):Array {

			var obj:Object = new Object();
			obj.values = values;

			if ( !values || values.length == 0 )
				return null;

			var filterFunction:Function = function( element:*, index:int, arr:Array ):Boolean {

				for ( var i:int = 0; i < this.values.length; i++ ) {
					if ( element[ searchProperty ] == this.values[ i ])
						return true;
				}

				return false;
			}

			return arr.filter( filterFunction, obj );
		}

		/**
		 *
		 * @param aArray
		 * @param oElement
		 * @param oParameter
		 * @return
		 */
		public static function findLastMatchIndex( aArray:Array, oElement:Object, oParameter:Object ):Number {

			var nStartingIndex:Number = aArray.length;
			var bPartialMatch:Boolean = false;

			if ( typeof arguments[ 2 ] == "number" ) {
				nStartingIndex = arguments[ 2 ];
			} else if ( typeof arguments[ 3 ] == "number" ) {
				nStartingIndex = arguments[ 3 ];
			}

			if ( typeof arguments[ 2 ] == "boolean" ) {
				bPartialMatch = arguments[ 2 ];
			}
			var bMatch:Boolean = false;

			for ( var i:Number = nStartingIndex; i >= 0; i-- ) {
				if ( bPartialMatch ) {
					bMatch = ( aArray[ i ].indexOf( oElement ) != -1 );
				} else {
					bMatch = ( aArray[ i ] == oElement );
				}

				if ( bMatch ) {
					return i;
				}
			}
			return -1;
		}

		/**
		 *
		 * @param aArray
		 * @param oElement
		 * @param rest
		 * @return
		 */
		public static function findMatchIndex( aArray:Array, oElement:Object, ... rest ):Number {

			var nStartingIndex:Number = 0;
			var bPartialMatch:Boolean = false;

			if ( typeof rest[ 0 ] == "number" ) {
				nStartingIndex = rest[ 0 ];
			} else if ( typeof rest[ 1 ] == "number" ) {
				nStartingIndex = rest[ 1 ];
			}

			if ( typeof rest[ 0 ] == "boolean" ) {
				bPartialMatch = rest[ 0 ];
			}
			var bMatch:Boolean = false;

			for ( var i:Number = nStartingIndex; i < aArray.length; i++ ) {
				if ( bPartialMatch ) {
					bMatch = ( aArray[ i ].indexOf( oElement ) != -1 );
				} else {
					bMatch = ( aArray[ i ] == oElement );
				}

				if ( bMatch ) {
					return i;
				}
			}
			return -1;
		}

		/**
		 *
		 * @param aArray
		 * @param oElement
		 * @param bPartialMatch
		 * @return
		 */
		public static function findMatchIndices( aArray:Array, oElement:Object, bPartialMatch:Boolean = false ):Array {

			var aIndices:Array = new Array();
			var nIndex:Number = findMatchIndex( aArray, oElement, bPartialMatch );

			while ( nIndex != -1 ) {
				aIndices.push( nIndex );
				nIndex = findMatchIndex( aArray, oElement, bPartialMatch, nIndex + 1 );
			}
			return aIndices;
		}

		
		/**
		 *	Returns a specified value from an Array Collection of both TYPED and UNTYPED objects.
		 *
		 *	@key the value you are searching for..
		 *
		 *  @searchProperty the property to search on
		 *
		 *	@data arraycollection of objects to search
		 *
		 *  @useTrim trim whitespace on either end
		 *
		 *  @matchCase match case of both values
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function getIndexFromCollection( key:*, searchProperty:String = null, data:* = null, useTrim:Boolean =
			true, matchCase:Boolean = true ):int {

			var result:int;

			result = getIndexFromTypedCollection( key, searchProperty, data, useTrim, matchCase );

			if ( result > -1 )
				return result;

			result = getIndexFromUnTypedCollection( key, searchProperty, data, useTrim, matchCase );

			if ( result > -1 )
				return result;

			return -1;
		}

		
		/**
		 * 
		 * @param key
		 * @param searchProperty
		 * @param data
		 * @param useTrim
		 * @param matchCase
		 * @return 
		 */
		public static function getIndexFromTypedCollection( key:*, searchProperty:String = null, data:* = null,
															useTrim:Boolean = true, matchCase:Boolean = true ):int {

			if(!validateCollectionSearchCriteria(data, key, searchProperty)) 
				return -1;

			var dataKey:String;
			var dateMatch:*;
			// Search getters/setters first

			var accList:XMLList;
			var varList:XMLList;
			var sourceObj:*;
			 

			// loop through collection and get value.
			for ( var i:int = 0; i < data.length; i++ ) {
				//****************************************
				// Compare different object types
				//****************************************
				sourceObj = data[ i ];

				if ( !accList )
					accList = flash.utils.describeType( sourceObj )..accessor;

				if ( !varList )
					varList = flash.utils.describeType( sourceObj )..variable;

				// Date
				if ( key is Date ) {
					dateMatch = ObjectUtil.getValueFromTypedObject( searchProperty, sourceObj, accList, varList );

					if ( dateMatch is Date ) {
						if ( DateUtil.compareDates( key as Date, dateMatch ) == 0 ) {
							//trace("index: " + i.toString());
							return i;
						}
					}

					// Ignore below
					continue;
				}

				// For Objects
				if ( useTrim ) {
					dataKey = StringUtil.trim( ObjectUtil.getValueFromTypedObject( searchProperty, sourceObj, accList, varList ));

					//trace("Trimmed: " + trimmedKey);

					if ( !matchCase ) {
						dataKey = dataKey.toLowerCase();
						key = key.toLowerCase();
					}

					if ( dataKey == key ) {
						return i;
					}

					continue;
				}

				dataKey = ObjectUtil.getValueFromTypedObject( searchProperty, sourceObj, accList, varList );

				if ( !dataKey )
					return -1;

				if ( !matchCase ) {
					dataKey = dataKey.toLowerCase();
					key = key.toLowerCase();
				}

				// Include whitespace on either end
				if ( dataKey == key ) {
					return i;
				}
			}

			//trace("getIndexFromTypedCollection: Property not found...")
			return -1;
		}

		/**
		 *	Returns respective match index from an Array Collection of UNTYPED objects.
		 *
		 *	@key the value you are searching for..
		 *
		 *  @searchProperty the property to search on
		 *
		 *	@data arraycollection of objects to search
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function getIndexFromUnTypedCollection( key:String, searchProperty:String = null, data:* = null,
															  useTrim:Boolean = true, matchCase:Boolean = true ):int {

			if(!validateCollectionSearchCriteria(data, key, searchProperty)) 
				return null;

			var dataKey:String;

			// loop through collection and get value.
			for ( var i:int = 0; i < data.length; i++ ) {
				if ( useTrim ) {
					dataKey = StringUtil.trim( ObjectUtil.getValueFromUnTypedObject( searchProperty, data[ i ]));

					//trace("Trimmed: " + trimmedKey);

					if ( !matchCase ) {
						dataKey = dataKey.toLowerCase();
						key = key.toLowerCase();
					}

					if ( dataKey == key ) {
						return i;
					}

					continue;
				}

				dataKey = ObjectUtil.getValueFromUnTypedObject( searchProperty, data[ i ]);

				if ( !dataKey )
					return -1;

				if ( !matchCase ) {
					dataKey = dataKey.toLowerCase();
					key = key.toLowerCase();
				}

				// Include whitespace on either end
				if ( dataKey == key ) {
					return i;
				}
			}

			//trace("getValueFromUnTypedCollection: Property not found...")
			return -1;
		}

		/**
		 * 
		 * @param searchProperty
		 * @param matchValue
		 * @param targetArray
		 * @return 
		 */
		 
		public static function getObjectFromTypedObjectArray( searchProperty:String, matchValue:String, targetArray:Array = null ):* {

			var keyValue:String = new String();

			for each ( var obj:Object in targetArray ) {
				keyValue = ObjectUtil.getValueFromTypedObject( searchProperty, obj );

				// Match passed in value.
				if ( keyValue == matchValue ) {
					return obj;
				}
			}

			// Return 'null' if no match is found
			return null;
		}

		/**
		 *	Returns a specified value from an Array Collection of both TYPED and UNTYPED objects.
		 *
		 *	@key the value you are searching for..
		 *
		 *  @searchProperty the property to search on
		 *
		 *	@data arraycollection of objects to search
		 *
		 *  @useTrim trim whitespace on either end
		 *
		 *  @matchCase match case of both values
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function getValueFromCollection( key:*, searchProperty:String = null, valueProperty:String = null,
													   data:* = null ):* {

			var result:*;

			// Search Typed collection first
			result = getValueFromTypedCollection( key, searchProperty, valueProperty, data );

			if ( result )
				return result;

			// Search Untyped collection second
			result = getValueFromUnTypedCollection( key, searchProperty, valueProperty, data );

			return result;
		}

		/**
		 *	Returns a specified value from an Array Collection of both TYPED and UNTYPED objects.
		 *
		 *	@key the value you are searching for..
		 *
		 *  @searchProperty the property to search on
		 *
		 *	@data array of objects to search
		 *
		 *  @useTrim trim whitespace on either end
		 *
		 *  @matchCase match case of both values
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		[Deprecated(message="This function has been deprecated. Please use the latest version.", replacement="getValueFromCollection", since="02-07-2015")]
		public static function getValueFromArray( key:*, searchProperty:String = null, valueProperty:String = null,
													   data:* = null ):* {
			
			var result:*;
			
			
			// Search Typed collection first
			result = getValueFromTypedObjectArray(key, searchProperty, valueProperty, data)
			
			if ( result )
				return result;
			
			// Search Untyped collection second
			result = getValueFromUnTypedObjectArray( key, searchProperty, valueProperty, data );
			
			return result;
		}

		  
		
		/**
		 * 
		 * @param value
		 * @param index
		 * @param delim
		 * @return 
		 */
		public static function getValueFromDelimitedString( value:String, index:int, delim:String = "_" ):String {

			var stringArray:Array = value.split( delim );

			if ( !stringArray || stringArray.length < 1 )
				return null;

			if ( !stringArray[ index ])
				return null;

			return stringArray[ index ] as String;

		}
		
		private static function get logger():LoggingManager{
			
			return LoggingManager.instance;
		}
		private static function validateCollectionSearchCriteria(data:*, key:*, searchProperty:String ):Boolean{
			
			if(!(data is ArrayCollection) && !(data is Array)) {
				logger.trace(ArrayUtil, "getValueFromTypedCollection(): Type is invalid for data parameter"); 
				return false;
			}
			
			if ( !key || !searchProperty || !data ) {
				logger.trace(ArrayUtil, "getValueFromTypedCollection: Parameter values missing..." ); 
				return false;
			}
			
			return true;
		}

		/**
		 *	Returns a specified value from an Array Collection of TYPED objects.
		 *
		 *	@key the value you are searching for..
		 *
		 *  @searchProperty the property to search on
		 *
		 *  @valueProperty the property to in which to retrieve the value.
		 *
		 *	@data arraycollection of objects to search
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function getValueFromTypedCollection( key:*, searchProperty:String = null, valueProperty:String = null,
															data:* = null ):* {

			if(!validateCollectionSearchCriteria(data, key, searchProperty)) 
				return null;
			  
			var dateMatch:*;

			var accList:XMLList;
			var varList:XMLList;
			var sourceObj:*;

			// loop through collection and get value.
			for ( var i:int = 0; i < data.length; i++ ) {

				sourceObj = data[ i ];

				if ( !accList )
					accList = flash.utils.describeType( sourceObj )..accessor;

				if ( !varList )
					varList = flash.utils.describeType( sourceObj )..variable;

				//****************************************
				// Compare different object types
				//****************************************

				if ( key is Date ) // Date
				{
					dateMatch = ObjectUtil.getValueFromTypedObject( searchProperty, sourceObj, accList, varList );

					if ( dateMatch is Date ) {
						if ( DateUtil.compareDates( key as Date, dateMatch ) == 0 ) {
							return ObjectUtil.getValueFromTypedObject( valueProperty, sourceObj, accList, varList );
						}
					}
				}
				// String
				else {
					if ( ObjectUtil.getValueFromTypedObject( searchProperty, sourceObj, accList, varList ) == key ) {
						return ObjectUtil.getValueFromTypedObject( valueProperty, sourceObj, accList, varList );
					}
				}
			}

			logger.trace(ArrayUtil, "getValueFromTypedCollection: value not found.");
			 
			return null;
		}

		/**
		 * 
		 * @param searchProperty
		 * @param matchValue
		 * @param valueProperty
		 * @param targetArray
		 * @return 
		 */
		[Deprecated(message="This function has been deprecated. Please use the latest version.", replacement="getValueFromTypedObjectArray", since="02-07-2015")]
		public static function getValueFromTypedObjectArray( searchProperty:String, matchValue:String, valueProperty:String = null,
															 targetArray:Array = null ):* {

			var keyValue:String = new String();

			for each ( var obj:Object in targetArray ) {
				keyValue = ObjectUtil.getValueFromTypedObject( searchProperty, obj );

				// Match passed in value.
				if ( keyValue == matchValue ) {
					return ObjectUtil.getValueFromTypedObject( valueProperty, obj );
				}
			}

			// Return 'null' if no match is found
			return null;
		}

		/**
		 *	Returns a specified value from an Array Collection of UNTYPED objects.
		 *
		 *	@key the value you are searching for..
		 *
		 *  @searchProperty the property to search on
		 *
		 *  @valueProperty the property to in which to retrieve the value.
		 *
		 *	@data arraycollection of objects to search
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function getValueFromUnTypedCollection( key:String, searchProperty:String = null, valueProperty:String = null,
															  data:* = null ):* {
			if(!validateCollectionSearchCriteria(data, key, searchProperty)) 
				return null;
			
			// loop through collection and get value.
			for ( var i:int = 0; i < data.length; i++ ) {
				if ( ObjectUtil.getValueFromUnTypedObject( searchProperty, data[ i ]) == key ) {
					return ObjectUtil.getValueFromUnTypedObject( valueProperty, data[ i ]);
				}
			}

			logger.trace(ArrayUtil, "getValueFromUnTypedCollection: value not found.");
			
			return null;
		}

		/**
		 * 
		 * @param searchProperty
		 * @param matchValue
		 * @param valueProperty
		 * @param targetArray
		 * @return 
		 */
		[Deprecated(message="This function has been deprecated. Please use the latest version.", replacement="getValueFromUnTypedCollection", since="02-07-2015")]
		public static function getValueFromUnTypedObjectArray( searchProperty:String, matchValue:String, valueProperty:String = null,
															   targetArray:Array = null ):* {

			var keyValue:String = new String();

			for each ( var obj:Object in targetArray ) {
				keyValue = ObjectUtil.getValueFromUnTypedObject( searchProperty, obj );

				// Match passed in value.
				if ( keyValue == matchValue ) {
					return ObjectUtil.getValueFromUnTypedObject( valueProperty, obj );
				}
			}

			// Return 'null' if no match is found
			return null;
		}

		/**
		 * 
		 * @param exclusions
		 * @param matchValue
		 * @return 
		 */
		public static function isExcluded( exclusions:Array, matchValue:String ):Boolean {

			// Handle excluded values
			if ( exclusions && exclusions.length > 0 ) {
				if ( exclusions.indexOf( matchValue ) >= 0 ) {
					return true;
				}
			}

			return false;
		}

		/**
		 *
		 * @param aArray
		 * @return
		 */
		public static function max( aArray:Array ):Number {

			var aCopy:Array = aArray.concat();
			aCopy.sort( Array.NUMERIC );
			var nMaximum:Number = Number( aCopy.pop());
			return nMaximum;
		}

		/**
		 *
		 * @param aArray
		 * @return
		 */
		public static function min( aArray:Array ):Number {

			var aCopy:Array = aArray.concat();
			aCopy.sort( Array.NUMERIC );
			var nMinimum:Number = Number( aCopy.shift());
			return nMinimum;
		}

		/**
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function sortAndFlattenStringArray( stringArray:Array, exclusions:Array = null, useReverseSort:Boolean = false,
														  separator:String = null ):String {

			var flattenedString:String = new String();

			if ( !separator )
				separator = "";

			if ( useReverseSort ) {
				stringArray.sort( Array.CASEINSENSITIVE | Array.DESCENDING );
			} else {
				stringArray.sort( Array.CASEINSENSITIVE );
			}

			// loop through collection and get value.
			for ( var i:int = 0; i < stringArray.length; i++ ) {

				// verify item is stringt
				if ( typeof stringArray[ i ] == "string" ) {

					// Handle excluded values
					if ( exclusions && exclusions.length > 0 ) {
						if ( exclusions.indexOf( stringArray[ i ]) >= 0 ) {
							trace( "excluded: " + stringArray[ i ]);
						} else {
							flattenedString += ( separator + stringArray[ i ]);
						}
					} else {
						flattenedString += ( separator + stringArray[ i ]);
					}
				}
			}

			if ( flattenedString.length > 0 )
				flattenedString += separator;

			return flattenedString;
		}

		/**
		 *
		 * @param aArray
		 * @return
		 */
		public static function sum( aArray:Array ):Number {

			var nSum:Number = 0;

			for ( var i:Number = 0; i < aArray.length; i++ ) {
				if ( typeof aArray[ i ] == "number" ) {
					nSum += aArray[ i ];
				}
			}
			return nSum;
		}

		/**
		 *
		 * @param aArray
		 * @param nIndexA
		 * @param nIndexB
		 */
		public static function switchElements( aArray:Array, nIndexA:Number, nIndexB:Number ):void {

			var oElementA:Object = aArray[ nIndexA ];
			var oElementB:Object = aArray[ nIndexB ];
			aArray.splice( nIndexA, 1, oElementB );
			aArray.splice( nIndexB, 1, oElementA );
		}

		/**
		 *
		 * @param oArray
		 * @param nLevel
		 * @return
		 */
		public static function toString( oArray:Object, nLevel:uint = 0 ):String {

			var sIndent:String = "";

			for ( var i:Number = 0; i < nLevel; i++ ) {
				sIndent += "\t";
			}
			var sOutput:String = "";

			for ( var sItem:String in oArray ) {
				if ( oArray[ sItem ] is Object ) {
					sOutput = sIndent + "** " + sItem + " **\n" + toString( oArray[ sItem ], nLevel + 1 ) + sOutput;
				} else {
					sOutput += sIndent + sItem + ":" + oArray[ sItem ] + "\n";
				}
			}
			return sOutput;
		}

		/**
		 * 
		 * @param searchProperty
		 * @param targetArray
		 * @param sourceArray
		 * @param exclusions
		 * @param addNewObjects
		 * @return 
		 */
		public static function updateMultipleUnTypedObjectsInArray( searchProperty:String, targetArray:Array, sourceArray:Array,
																	exclusions:Array = null, addNewObjects:Boolean = false ):Array {

			var matchValue:String = new String();
			var updatedArray:Array;
			var obj:Object;

			// Add new objects to array if specified.
			obj = new Object();

			if ( addNewObjects ) {
				for each ( obj in sourceArray ) {
					matchValue = ObjectUtil.getValueFromUnTypedObject( searchProperty, obj );

					if ( isExcluded( exclusions, matchValue ) == false ) {
						updatedArray = addUnTypedObjectToArray( searchProperty, matchValue, obj, targetArray );

						// New items added
						if ( updatedArray != null ) {
							targetArray = updatedArray;
						}
					}
				}
			}

			// Update existing objects in array.
			obj = new Object();

			for each ( obj in sourceArray ) {
				matchValue = ObjectUtil.getValueFromUnTypedObject( searchProperty, obj );

				if ( isExcluded( exclusions, matchValue ) == false ) {
					if ( matchValue != null && matchValue != "" ) {
						targetArray = updateUnTypedObjectInArray( searchProperty, matchValue, obj, targetArray );
					}
				}
			}

			return targetArray;

		}

		/**
		 *
		 * @param propKey
		 * @param propMatch
		 * @param updateValue
		 * @param sourceArray
		 * @return
		 */
		public static function updateUnTypedObjectInArray( searchProperty:String, matchValue:String, updateValue:Object, targetArray:Array,
														   addObject:Boolean = false ):Array {

			var key:String;

			if ( targetArray == null || targetArray.length == 0 ) {
				return targetArray;
			}

			for ( var i:int = 0; i < targetArray.length; i++ ) {
				key = ObjectUtil.getValueFromUnTypedObject( searchProperty, targetArray[ i ]);

				if ( key == matchValue ) {
					targetArray.splice( i, 1, updateValue );
					return targetArray;
				}
			}

			// Object wasn't found - push it
			if ( addObject ) {
				targetArray.push( updateValue );
			}

			return targetArray;
		}

		private static function objectEquals( oInstanceA:Object, oInstanceB:Object ):Boolean {

			for ( var sItem:String in oInstanceA ) {
				if ( oInstanceA[ sItem ] is Object ) {
					if ( !objectEquals( oInstanceA[ sItem ], oInstanceB[ sItem ])) {
						return false;
					}
				} else {
					if ( oInstanceA[ sItem ] != oInstanceB[ sItem ]) {
						return false;
					}
				}
			}
			return true;
		}
	}

}
