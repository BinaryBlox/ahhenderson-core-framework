//------------------------------------------------------------------------------
//
//   Copyright ViziFit, Inc. 2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.interfaces {
	


	public interface ICommandActor extends IFacadeActor {

		function executeCommand(message:IFacadeMessage):void;
	}
}
