//------------------------------------------------------------------------------
//
//   Copyright ViziFit, Inc. 2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.interfaces._deprecate {
	import mx.collections.ArrayList;
 

	public interface IBaseList {
 
		
		function get dataProvider():ArrayList;
		function set dataProvider(value:ArrayList):void;
		
		function get itemRenderer():Class;
		function set itemRenderer(value:Class):void;
		
		function get itemRendererPropertyBag():Object;
		function set itemRendererPropertyBag(value:Object):void;
		
		function get labelField():String;
		function set labelField(value:String):void;
		
		function get rendererKey():String;
		function set rendererKey(value:String):void;
		
		function get selectedIndex():int;
		function set selectedIndex(value:int):void;
		
		function get useVirtualLayout():Boolean;
		function set useVirtualLayout(value:Boolean):void;
		 
		  
	}
}