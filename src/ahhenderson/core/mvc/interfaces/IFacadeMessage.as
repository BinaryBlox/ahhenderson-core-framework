//------------------------------------------------------------------------------
//
//   Copyright ViziFit, Inc. 2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.interfaces
{
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	
	public interface IFacadeMessage
	{

		//function setArgs( ...args ):void;	

		function get args():Array;

		//function setMessageFilter():void;

		//function setMessageBody( body:Object ):void;

		function get messageBody():Object;

		//function setMessageId():void;

		function get messageFilter():FacadeMessageFilter;

		function get messageId():String;
		//function toString():String;
	}
}