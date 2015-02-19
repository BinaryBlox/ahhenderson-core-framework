//------------------------------------------------------------------------------
//
//   Copyright Anthony Henderson  2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.interfaces {
	import ahhenderson.core.managers.dependency.device.enums.SuspendModeTypeEnum;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;


	public interface IFacadeView {

		// properties 
		function get mediatorGuid():String;

		function get mediatorKey():String;

		function set mediatorKey(value:String):void;

		function get mediatorName():String;

		function get messageGroupsFilter():Array;

		function set messageGroupsFilter(value:Array):void;

		function get messageTypesFilter():Array;

		function set messageTypesFilter(value:Array):void; 
		
		function get strictMessageFilter():Boolean;

		function set strictMessageFilter(value:Boolean):void;

		function get suspendMode():SuspendModeTypeEnum;
		
		// functions/methods
		function registerMediator(mediator:IMediatorActor, messageFilter:FacadeMessageFilter, useStarling:Boolean = true, ...args):void;
		
		function removeMediator():Boolean;
	}
}
