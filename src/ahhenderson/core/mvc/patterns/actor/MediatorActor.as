//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.patterns.actor {

	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import ahhenderson.core.ahhenderson_internal;
	import ahhenderson.core.mvc.enums.ActorType;
	import ahhenderson.core.mvc.interfaces.IFacadeView;
	import ahhenderson.core.mvc.interfaces.IMediatorActor;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	
	import starling.events.Event;

	use namespace ahhenderson_internal;


	public class MediatorActor extends AbstractFacadeActor implements IMediatorActor {

		public function MediatorActor( name:String = null, component:Object = null ) {

			super( name );

			this.component = component;
		}

		override public function get actorType():ActorType {

			return ActorType.MEDIATOR;
		}

		protected var component:Object;

		public function getComponent():Object {

			return component;
		}

		override public function beforeRemove():void {

			//LogHpr.log(LType.INFO, LCategory.MVC, "REMOVING mediator", "Mediator Id: " + this.mediatorName +  this.mediatorKey);  
			trace( "Before remove!!" );

			if ( useStarling ) {

				if ( !( component is starling.events.EventDispatcher )) {
					throw new Error( "Starling Dispatcher: Issue with starling" );
				}

				starling.events.EventDispatcher( component ).removeEventListener( starling.events.Event.REMOVED_FROM_STAGE,
																				  onRemoveFromStarlingStage );
				starling.events.EventDispatcher( component ).removeEventListener( starling.events.Event.REMOVED, onStarlingClose );

			} else {
				component.removeEventListener( flash.events.Event.REMOVED_FROM_STAGE, onRemoveFromStage );
				component.removeEventListener( FlexEvent.REMOVE, onClose );
			}

			this.remove(); // Remove from facade.
		}

		public function onClose( event:FlexEvent ):void {

			/*	if (suspendMode)
					if (suspendMode == SuspendModeTypeEnum.ON)
						return;*/

			super.beforeRemove();
			//trace("method not implemented...");
		}

		override public function onRegister():void {

			IFacadeView( component ).mediatorKey = this.actorKey;

			if ( useStarling ) {

				if ( !( component is starling.events.EventDispatcher )) {
					throw new Error( "Starling dispatcher: Issue with starling" );
				}
				starling.events.EventDispatcher( component ).addEventListener( starling.events.Event.REMOVED_FROM_STAGE,
																			   onRemoveFromStarlingStage );
				starling.events.EventDispatcher( component ).addEventListener( starling.events.Event.REMOVED, onStarlingClose );
				return;
			}

			// for standard events
			component.addEventListener( flash.events.Event.REMOVED_FROM_STAGE, onRemoveFromStage );
			component.addEventListener( FlexEvent.REMOVE, onClose );

		}

		public function onRemoveFromStage( event:flash.events.Event ):void {

			trace( "REMOVING mediator (onRemoveFromStage): ", this.actorKey );
			/*	if (suspendMode)
					if (suspendMode == SuspendModeTypeEnum.ON)
						return;*/

			beforeRemove();
		}

		public function onRemoveFromStarlingStage( event:starling.events.Event ):void {

			/*if (suspendMode)
				if (suspendMode == SuspendModeTypeEnum.ON)
					return;*/

			trace( "REMOVING mediator (onRemoveFromStarlingStage): ", this.actorKey );

			beforeRemove();
		}

		public function onStarlingClose( event:starling.events.Event ):void {

			// Prevent removal of mediators caused from other events that bubbled up.
			if ( !( event.currentTarget is IFacadeView ))
				return;

			if ( IFacadeView( event.currentTarget ).mediatorKey != this.actorKey )
				return;

			/*if (suspendMode)
				if (suspendMode == SuspendModeTypeEnum.ON)
					return;*/

			beforeRemove();
			//trace("method not implemented...");
		}

		override public function remove():void {

			if ( !this.actorName )
				return;

			GlobalFacade.instance.unRegisterActor( this.actorName, this._key );
		}

		public function setComponent( component:Object ):void {

			this.component = component;
		}

		override protected function setMessageFilter():void {
			GlobalFacade.instance.registerMediator(this, _messageFilter  );
			 
		}

	}
}
