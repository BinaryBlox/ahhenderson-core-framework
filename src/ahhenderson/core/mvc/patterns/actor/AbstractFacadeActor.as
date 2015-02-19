//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.patterns.actor {

	import flash.events.TimerEvent;
	
	import ahhenderson.core.ahhenderson_core_internal;
	import ahhenderson.core.mvc.enums.ActorType;
	import ahhenderson.core.mvc.interfaces.IFacadeActor;
	import ahhenderson.core.mvc.interfaces.IFacadeMessage;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	import ahhenderson.core.util.CustomTimer;
	import ahhenderson.core.util.GuidUtil;

	use namespace ahhenderson_core_internal;
	
	internal class AbstractFacadeActor implements IFacadeActor {
 
		// Supporting global suspension
		include "../../../_includes/_SuspendModeIncludes.inc"

		public static const NAME:String = 'AbstractFacadeActor';

		public function AbstractFacadeActor( name:String = null ) {

			this._actorName = ( name != null ) ? name : NAME;
			this._key = "_" + GuidUtil.createUID();

		}

		
		protected var _key:String;

		protected var _actorName:String;
		
		protected var _delayTimer:CustomTimer;
		
		
		
		public function get actorKey():String {

			return this._key;
		}
		
		public function beforeRemove():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function get actorType():ActorType
		{
			throw new Error("Must override actorType");
		}
		
		 
		 
		protected var _messageFilter:FacadeMessageFilter;

		public function get messageFilter():FacadeMessageFilter {

			return _messageFilter;
		}

		public function set messageFilter( value:FacadeMessageFilter ):void {

			_messageFilter = value;
			setMessageFilter();
		}
		
		public function handleFacadeMessage(message:IFacadeMessage):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function onRegister():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function onRemove():void
		{
			// TODO Auto Generated method stub
			
		}
		
		

		protected var _useStarling:Boolean;

		public function get useStarling():Boolean {

			return _useStarling;
		}

		public function set useStarling( value:Boolean ):void {

			_useStarling = value;
		}

		public function register( actor:IFacadeActor, messageFilter:FacadeMessageFilter, useStarling:Boolean = true, ... args ):String {

			// Identify starling components
			if ( useStarling )
				_useStarling = useStarling;

			_messageFilter = messageFilter;
			setMessageFilter();

			// Return unique key
			return _actorName + _key;
		}

		public function get actorName():String {

			return this._actorName;
		}

		public function remove():void {

			if ( !this._actorName )
				return;

			GlobalFacade.instance.unRegisterActor( this._actorName, this._key );
		}

		protected function sendDelayedFacadeMessage( delay:int, message:FacadeMessage ):void {

			_delayTimer = new CustomTimer( delay, 1 );
			_delayTimer.TimerData = message;
			_delayTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onDelayMessageComplete, false, 0, true );
			_delayTimer.start();
		}

		protected function sendFacadeMessage( messageId:String, messageBody:Object = null, messageFilter:FacadeMessageFilter = null,
											  ... args ):void {

			GlobalFacade.instance.sendMessage.apply( null, [ messageId, messageBody, messageFilter ].concat( args ));
		}

		protected function sendFacadeMessageObject( message:FacadeMessage ):void {

			GlobalFacade.instance.sendMessageObject( message );
		}

		protected function onDelayMessageComplete( e:TimerEvent ):void {

			if ( _delayTimer.TimerData is FacadeMessage )
				GlobalFacade.instance.sendMessageObject( _delayTimer.TimerData as FacadeMessage );

			_delayTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, onDelayMessageComplete );

		}

		protected function setMessageFilter():void {
			//GlobalFacade.instance.registerMediator(this, this._key, _messageFilter);
		}
	}
}
