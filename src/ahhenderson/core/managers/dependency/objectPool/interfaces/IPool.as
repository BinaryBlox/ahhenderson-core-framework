package ahhenderson.core.managers.dependency.objectPool.interfaces
{
	public interface IPool
	{
		function borrowObject():*;
		
		function returnObject(object:*):void;
		
		function get size():int;
		
		function get unused():int;
		
		function get used():int;
		
		function get ObjectClass():Class;
		 
		function get defaultResetObjectFunction():Function;
		
		
		function optimize():void;
		
		function flush(force:Boolean = false, disposeUnusedObjects:Boolean = false):void;
		
		function dispose():void;
		
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
	}
}