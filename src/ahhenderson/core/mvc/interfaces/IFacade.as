//------------------------------------------------------------------------------
//
//   Copyright Anthony Henderson  2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.interfaces {

	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;

 
	public interface IFacade {

		function registerCommand( command:ICommandActor, 
								  messageFilter:FacadeMessageFilter = null, 
								  messageDomain:String = null ):void;

		function registerMediator( mediator:IMediatorActor, 
								   messageFilter:FacadeMessageFilter = null, 
								   messageDomain:String = null ):void;

		function registerModel( model:IModelActor, 
								messageFilter:FacadeMessageFilter = null, 
								messageDomain:String = null ):void;

		function unRegisterModel( actorName:String ):Boolean;

		function unRegisterMediator( actorName:String, actorKey:String ):Boolean;

		function unRegisterCommand( actorName:String, actorKey:String ):Boolean;
		
		function getModel( actorName:String ):IModelActor;
		
		function getMediator( actorName:String, actorKey:String ):IMediatorActor;
		
		function getCommand( actorName:String, actorKey:String ):ICommandActor;

	}
}