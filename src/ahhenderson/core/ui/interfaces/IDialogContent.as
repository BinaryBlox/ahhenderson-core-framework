//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.ui.interfaces {
	import org.osflash.signals.ISignal;

	public interface IDialogContent {
 
		function get args():Array; 
		function set args(value:Array):void;
 
		function get icon():String; 
		function set icon(value:String):void;

		function get message():String 
		function set message(value:String):void 

		function get padding():int; 
		function set padding(value:int):void;
 
		function get title():String; 
		function set title(value:String):void;
		
		function get width():Number; 
		function set width(value:Number):void;
		
		function get height():Number; 
		function set height(value:Number):void;
		 
		function get onClose():ISignal;

	}
}
