//------------------------------------------------------------------------------
//
//   Copyright Anthony Henderson  2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.interfaces {

	import ahhenderson.core.mvc.enums.ActorType;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;


	public interface IFacadeActor {

		function get actorName():String;

		function get actorKey():String;
		
		function get actorType():ActorType;

		function get messageFilter():FacadeMessageFilter;

		function set messageFilter( value:FacadeMessageFilter ):void;

		function handleFacadeMessage( message:IFacadeMessage ):void;

		function onRegister():void;

		function onRemove():void;

		function beforeRemove():void;

		function register( actor:IFacadeActor, messageFilter:FacadeMessageFilter, useStarling:Boolean = true, ... args ):String;

		function remove():void;

	}
}
