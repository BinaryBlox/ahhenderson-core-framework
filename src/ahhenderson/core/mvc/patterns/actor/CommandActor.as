//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.patterns.actor {
	import ahhenderson.core.ahhenderson_core_internal;
	import ahhenderson.core.mvc.enums.ActorType;
	import ahhenderson.core.mvc.interfaces.ICommandActor;
	import ahhenderson.core.mvc.interfaces.IFacadeMessage;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	
	use namespace ahhenderson_core_internal;
	
	public class CommandActor extends AbstractFacadeActor implements ICommandActor {

		 
		public function CommandActor(name:String = null) {
			
			super(name);
			 
		}
		
		override public function get actorType():ActorType
		{ 
			return ActorType.COMMAND;
		}
		
		override public function handleFacadeMessage(message:IFacadeMessage):void{
			
			// Only filter one message type for command 
			if(message.messageId != this.actorName)
				return;
			
			executeCommand(message);
			 
		}
 
		public function executeCommand(message:IFacadeMessage):void{
			
			throw new Error("Must override executeCommand.");
		}

		override public function beforeRemove():void {

			//LogHpr.log(LType.INFO, LCategory.MVC, "REMOVING mediator", "Mediator Id: " + this.mediatorName +  this.mediatorKey);  
			trace("Before remove!!");
			
			
			this.remove(); // Remove from facade.
		}

		 

		override public function onRegister():void {

			//LogHpr.log(LType.INFO, LCategory.MVC, "ADDING mediator", "Mediator Id: " + this.mediatorName +  this.mediatorKey);
		  
			trace( "ADDING actor: ", this.actorKey);
			 

		}
 

		override public function remove():void {
			if (!this.actorName)
				return;

			GlobalFacade.instance.unRegisterActor(this.actorName, this._key);
		}
 
		 
 
	}
}
