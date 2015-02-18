//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.ui.interfaces {
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	
	import starling.textures.Texture;

	public interface ITileListItem {
  
		function get key():String;  
		
		function get label():String;  
 
		function get texture():Texture;  

		function get message():FacadeMessage 

	}
}
