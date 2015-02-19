//------------------------------------------------------------------------------
//
//   Copyright Anthony Henderson  2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.interfaces {
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import starling.events.Event;


	public interface IMediatorActor extends IFacadeActor {

		function getComponent():Object;
  
		function onClose(event:FlexEvent):void; 
		
		function onRemoveFromStage(event:flash.events.Event):void;

		function onRemoveFromStarlingStage(event:starling.events.Event):void;

		function onStarlingClose(event:starling.events.Event):void;

		//function register(mediator:IFacadeMediator, messageFilter:FacadeMessageFilter, useStarling:Boolean = true, ... args):String;
 
		function setComponent(component:Object):void;
	}
}
