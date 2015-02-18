//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.ui.interfaces {
	import feathers.data.ListCollection;


	public interface IMenuContent   {
 
		// Getter/Setters 
		function get visible():Boolean;
		function set visible(value:Boolean):void;
  
		function get dataProvider():ListCollection;
		function set dataProvider(value:ListCollection):void;
		   
	 
	}
}
