
package ahhenderson.core.managers.dependency.objectPool.interfaces {
	import ahhenderson.core.collections.HashMapList;
	import ahhenderson.core.interfaces.IDisposable;

	public interface IPoolObject extends IDisposable {

	  
		/**
		 * Enumeration for the type of object used in the pool
		 *
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		 
		function get poolType():IPoolType;
		
		function set poolType(value:IPoolType):void; 
		
		/**
		 * Enumeration for the type of object used in the pool
		 *
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		
		function get properties():HashMapList;
		
		 
		function get objId():String; 
		
		function get isPooled():Boolean; 
		
		function set isPooled(value:Boolean):void; 
		
		function initObject(objId:String):void;
		
		/**
		 * States whether or not object is for use with stage3d
		 *
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		
		function resetObject():void;
		
		
		function set resetObjectFunction(value:Function):void; 
		  
		function get resetObjectFunction():Function;
		  
		
	}
}
