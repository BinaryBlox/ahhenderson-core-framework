//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.ui.interfaces
{
	public interface IContainerLayout
	{
		function get direction():String;
		/**
		 * 
		 * @Use LayoutHelper.DIRECTION_VERITCAL or LayoutHelper.DIRECTION_HORIZONTAL
		 */
		function set direction(value:String):void;
		
		function get gap():Number;
		function set gap(value:Number):void;
		
		function get horizontalAlignment():String;
		function set horizontalAlignment(value:String):void;
		
		function get padding():Number;
		function set padding(value:Number):void;
		
		function get verticalAlignment():String;
		function set verticalAlignment(value:String):void;
	
	}
}