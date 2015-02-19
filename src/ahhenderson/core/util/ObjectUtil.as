//------------------------------------------------------------------------------
//
//   Anthony Henderson  
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package  ahhenderson.core.util
{
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	
	import avmplus.getQualifiedClassName;

	public class ObjectUtil
	{


		public static function createTypedObject(sourceObj:*, targetObject:Object):*
		{

			// Loop through properties of typed object to find match & return value 
			var i:int;

			// Search getters/setters first
			var varList:XMLList=flash.utils.describeType(targetObject)..accessor;

			for (i=0; i < varList.length(); i++)
			{

				if (sourceObj[varList[i].@name] is Object)
				{

				}
				else
					targetObject[varList[i].@name]=ObjectUtil.getValueFromUnTypedObject(varList[i].@name, sourceObj);

					// DEBUG:
					//trace(varList[i].@name+':'+ sourceObj[varList[i].@name]);
			}

			// Search variables 
			varList=flash.utils.describeType(targetObject)..variable;

			for (i=0; i < varList.length(); i++)
			{

				targetObject[varList[i].@name]=ObjectUtil.getValueFromUnTypedObject(varList[i].@name, sourceObj);

					// DEBUG:
					//trace(varList[i].@name+':'+ sourceObj[varList[i].@name]);
			}


			return targetObject;
			trace("createTypedObject: No property found...");
		}

		public static function getValueFromObject(propertyName:String, sourceObj:*, accList:XMLList=null, varList:XMLList=null):*{
			 
			var result:*
			
			if(accList || varList)
					result = getValueFromTypedObject(propertyName, sourceObj, accList, varList);
			
			if(!result) 
				result = getValueFromUnTypedObject(propertyName, sourceObj);
			 
			return result;
		}
		
		/**
		 *	Returns a specified value from an untyped object.
		 *
		 *	@propertyName the property you wish to find and return.
		 *
		 *	@sourceObj the object to iterate through.
		 *  
		 *  IMPORTANT NOTE: This function will NOT work with dynamic objects.
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function getValueFromTypedObject(propertyName:String, sourceObj:*, accList:XMLList=null, varList:XMLList=null ):*
		{
			// Loop through properties of typed object to find match & return value 
			var i:int; 
			
			// Search getters/setters first
			if(!accList)
				accList = flash.utils.describeType(sourceObj)..accessor;
			
			for(i=0; i < accList.length(); i++){
				
				if(propertyName == accList[i].@name){
					return sourceObj[accList[i].@name]; 
				} 
				// DEBUG:
				//trace(varList[i].@name+':'+ sourceObj[varList[i].@name]);
			} 
			
			// Search variables 
			if(!varList)
				varList = flash.utils.describeType(sourceObj)..variable;
			
			for(i=0; i < varList.length(); i++){
				
				if(propertyName == varList[i].@name){
					return sourceObj[varList[i].@name]; 
				} 
				// DEBUG:
				//trace(varList[i].@name+':'+ sourceObj[varList[i].@name]);
			} 
			
			return null;
			trace("getValueFromObjectByProp: No property found...");		
		}


		/**
		 *	Returns a specified value from an untyped object.
		 *
		 *	@propertyName the property you wish to find and return.
		 *
		 *	@sourceObj the object to iterate through.
		 *
		 *  IMPORTANT NOTE: Will not work with getters and setters and won't read properties;
		 *  have top use variables. use getValueFromObjectByProp for accessing properties.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function getValueFromUnTypedObject(propertyName:String, sourceObj:*):*
		{

			// Loop through properties of untyped object to find match & return value
			for (var i:String in sourceObj)
			{
				if (i == propertyName)
				{
					return sourceObj[i];
				}
			}

			return null;
			trace("getValueFromUnTypedObject: No property found...");
		}


		/**
		 *	Returns a specified value from an untyped object.
		 *
		 *	@propertyName the property you wish to find and return.
		 *
		 *	@sourceObj the object to iterate through.
		 *
		 *  IMPORTANT NOTE: This function will NOT work with dynamic objects.
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function instrospectObject(sourceObj:*, isTypedObject:Boolean=false):Array
		{

			// Loop through properties of typed object to find match & return value 
			var i:int;
			var propsArray:Array= []; 
			
			if(getQualifiedClassName(sourceObj) != "Object")
				isTypedObject=true;
			
			
			if (isTypedObject)
			{
				// Search getters/setters first
				var varList:XMLList=flash.utils.describeType(sourceObj)..accessor; 

				for (i=0; i < varList.length(); i++)
				{ 
					if (varList[i].@name) 
						propsArray.push( String(varList[i].@name).toString() );
					 
						// DEBUG:
						//trace(varList[i].@name+':'+ sourceObj[varList[i].@name]);
				}

				// Search variables 
				varList=flash.utils.describeType(sourceObj)..variable;

				for (i=0; i < varList.length(); i++)
				{ 
					if (varList[i].@name) 
						propsArray.push(String(varList[i].@name).toString() );
					  	// DEBUG:
						//trace(varList[i].@name+':'+ sourceObj[varList[i].@name]);
				}
			}
			else
			{
				// Loop through properties of untyped object to find match & return value
				for (var propName:String in sourceObj)
				{
					if (propName) 
						propsArray.push(propName); 
				}
			}


			return propsArray;
			//trace("getValueFromObjectByProp: No property found...");
		}
	
		/**
		 * Compares two objects and checks if they are identical. Does not compare the objects by reference,
		 * but compares to see if the values of the properties are identical.
		 *
		 * @param obj1
		 * @param obj2
		 *
		 * @return
		 */
		public static function compareByteArray(b1:ByteArray, b2:ByteArray):Boolean {
			 
			// compare the lengths first
			var size:uint = b1.length;
			if (b1.length == b2.length) {
				b1.position = 0;
				b2.position = 0;
				
				// then the bits
				while (b1.position < size) {
					var v1:int = b1.readByte();
					if (v1 != b2.readByte()) {
						return false;
					}
				}
			}
			if (b1.toString() == b2.toString()) {
				return true;
			}
			return false;
		}
		
		/**
		 * Compares two objects and checks if they are identical. Does not compare the objects by reference,
		 * but compares to see if the values of the properties are identical.
		 *
		 * @param obj1
		 * @param obj2
		 *
		 * @return
		 */
		public static function compare(obj1:Object, obj2:Object):Boolean {
			var b1:ByteArray = new ByteArray();
			var b2:ByteArray = new ByteArray();
			b1.writeObject(obj1);
			b2.writeObject(obj2);
			
			// compare the lengths first
			var size:uint = b1.length;
			if (b1.length == b2.length) {
				b1.position = 0;
				b2.position = 0;
				
				// then the bits
				while (b1.position < size) {
					var v1:int = b1.readByte();
					if (v1 != b2.readByte()) {
						return false;
					}
				}
			}
			if (b1.toString() == b2.toString()) {
				return true;
			}
			return false;
		}
	}
}

