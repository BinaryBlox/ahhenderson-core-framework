//------------------------------------------------------------------------------
//
//   Copyright ViziFit, Inc. 2010 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.patterns.facade {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	
	import ahhenderson.core.ahhenderson_internal;
	import ahhenderson.core.mvc.enums.ActorType;
	import ahhenderson.core.mvc.enums.GlobalFacadeActionType;
	import ahhenderson.core.mvc.events.GlobalFacadeMessageEvent;
	import ahhenderson.core.mvc.interfaces.ICommandActor;
	import ahhenderson.core.mvc.interfaces.IFacade;
	import ahhenderson.core.mvc.interfaces.IFacadeActor;
	import ahhenderson.core.mvc.interfaces.IFacadeMessage;
	import ahhenderson.core.mvc.interfaces.IMediatorActor;
	import ahhenderson.core.mvc.interfaces.IModelActor;
	import ahhenderson.core.mvc.patterns.actor.ActorState;
	import ahhenderson.core.mvc.patterns.actor.ModelActor;
	import ahhenderson.core.util.CustomTimer;

	use namespace ahhenderson_internal;
	
	[Event(name = "globalMessageManagerEvent", type = "ahhenderson.core.mvc.events.GlobalFacadeMessageEvent")] 
	public final class GlobalFacade extends EventDispatcher implements IFacade {

		/**
		 * Constructor
		 *
		 * @param lock The Singleton lock class to pevent outside instantiation.
		 */
		public function GlobalFacade(lock:Class) {
			// Verify that the lock is the correct class reference.
			if (lock != SingletonLock) {
				throw new Error("Invalid Singleton access.  Use Model.instance.");
			}

			_registeredActors = new Vector.<ActorState>();

		}

		private static const MESSAGE_SEPARATOR:String = "|";

		/** Storage for the singleton instance. */
		private static const _instance:GlobalFacade = new GlobalFacade(SingletonLock);

		/** Provides singleton access to the instance. */
		public static function get instance():GlobalFacade {
			return _instance;
		}


		private var _delayTimer:CustomTimer;

		private var _registeredActors:Vector.<ActorState>;

		override public function dispatchEvent(event:Event):Boolean {

			//TODO: Add Key to match from facade instance.
			return super.dispatchEvent(event);

		}
		 
		/**
		 * 
		 * @param actorName
		 * @param actorKey
		 * @return 
		 */
		ahhenderson_internal function removeActor(actorName:String, actorKey:String):Boolean {
			var existingIndex:int = searchRegisteredActors(actorName, actorKey);
			var bSuccess:Boolean;
			
			try {
				if (existingIndex >= 0) {
					
					prepareActorForRemoval(existingIndex);
					
					//rebuildMediatorArray(existingIndex);
					trace("Actor removed: " + actorName + actorKey);
				} else
					trace("Actor not found: " + actorName + actorKey);
					
					bSuccess = true;
			} catch (error:Error) {
				trace("mediatorTearDown Error: " + error.message + actorKey);
			} finally {
				return bSuccess;
			}
		}

		// Rebuilds array after removing existing actor
		/**
		 *
		 * @param existingIndex
		 */
		ahhenderson_internal function rebuildActorArray(existingIndex:int):void {

			var varr:Vector.<ActorState> = new Vector.<ActorState>();

			for (var i:int = 0; i < _registeredActors.length; i++) {
				if (i != existingIndex)
					varr.push(_registeredActors[i]);

			}

			_registeredActors = varr;
		}

 
		/**
		 * 
		 * @param actor (Mediator, Model or Command)
		 * @param messageFilter
		 * @param messageDomain
		 */
		ahhenderson_internal function registerActor(actor:IFacadeActor, 
													messageFilter:FacadeMessageFilter = null, 
													messageDomain:String = null ):void {
			
			trace("Registering actor type: " + actor.actorType.value);
			addActor(new ActorState(actor, actor.actorKey, messageFilter, messageDomain ));
		}


		/**
		 *
		 * @return
		 */
		public function get registeredActors():Vector.<ActorState> {
			return _registeredActors;
		}
		 
		/**
		 * 
		 * @param actorName
		 * @param actorKey
		 * @return 
		 */
		ahhenderson_internal function unRegisterActor(actorName:String, actorKey:String):Boolean {
			var existingIndex:int = searchRegisteredActors(actorName, actorKey);
			var bSuccess:Boolean;

			try {
				if (existingIndex >= 0) {
					rebuildActorArray(existingIndex);
						trace("Actor removed: " + actorName + actorKey);
				} else
					//trace("Actor not found: " + mediatorName + mediatorKey);

					bSuccess = true;
			} catch (error:Error) {
				trace("unRegisterActor Error: " + error.message + actorKey);
			} finally {
				return bSuccess;
			}
		}

		/**
		 *
		 * @param delay (in milliseconds)
		 * @param message
		 */
		public function sendDelayedMessage(delay:int, message:FacadeMessage):void {
			_delayTimer = new CustomTimer(delay, 1);
			_delayTimer.TimerData = message;
			_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayMessageComplete, false, 0, true);
			_delayTimer.start();
		}

		/**
		 *
		 * @param messageId
		 * @param messageBody
		 * @param messageFilter
		 * @param args
		 */
		public function sendMessage(messageId:String, messageBody:Object = null, messageFilter:FacadeMessageFilter = null, ... args):void {

			var globalMessage:FacadeMessage = new FacadeMessage(messageId, messageBody, messageFilter);
			globalMessage.setArgs.apply(null, args);

			// Publish message to non-mediators.
			dispatchEvent(new GlobalFacadeMessageEvent(GlobalFacadeMessageEvent.GLOBAL_MESSAGE_MANAGER_EVENT, GlobalFacadeActionType.ROUTE_GLOBAL_MESSAGE, globalMessage, true));

			// Publish message to all respective mediators.
			publishMessageToRegisteredActors(globalMessage);
		}

		/**
		 *
		 * @param globalMessage
		 */
		public function sendMessageObject(globalMessage:FacadeMessage):void {

			// Publish message to non-mediators.
			dispatchEvent(new GlobalFacadeMessageEvent(GlobalFacadeMessageEvent.GLOBAL_MESSAGE_MANAGER_EVENT, GlobalFacadeActionType.ROUTE_GLOBAL_MESSAGE, globalMessage, true));

			// Publish message to all respective mediators.
			publishMessageToRegisteredActors(globalMessage);
		}

		/**
		 *
		 * @param key
		 * @param messageGroups
		 * @param messageTypes
		 * @param isMediator
		 * @return
		 */
		public function updateMessageFilter(key:String, messageGroups:Array = null, messageTypes:Array = null, isMediator:Boolean = true):Boolean {
			var messageFilterSO:FacadeMessageFilter = new FacadeMessageFilter(messageGroups, messageTypes);
			var uid:String;

			if (isMediator) {
				if (_registeredActors == null || _registeredActors.length == 0) {
					return false;
					trace("No actors are registered...");
				}

				for each (var actorState:ActorState in _registeredActors) {

					uid = actorState.actorKey;
					if (key == uid) {
						 trace("Updating mediator actor filter: " + uid); 
						actorState.messageFilter = IFacadeActor( actorState.actor).messageFilter = messageFilterSO;
						return true;
					}
				}
			} else {
				if (_registeredActors == null || _registeredActors.length == 0) {
					return false;
					trace("No facade modules are registered...");
				}
			}

			trace("updateMessageFilter: No members found to update...");
			return false;
		}

		private function addActor(actorState:ActorState):Boolean {

			var actor:IFacadeActor = actorState.actor;
			var actorName:String = actor.actorName;
			var existingIndex:int = searchRegisteredActors(actorName, actorState.actorKey);
			var bSuccess:Boolean;

			try {
				if (existingIndex >= 0) {
					trace("Actor already exists..." + actorName + actorState.actorKey);
				} else {
					trace("Adding Actor: " + actorName + actorState.actorKey);
					_registeredActors.push(actorState);
					 
					
					actor.onRegister();
				}

				bSuccess = true;
			} catch (error:Error) {
				trace("Adding Actor Error[" + actorName + "]: " + error.message + "\n\n" + error.getStackTrace());
			} finally {
				return bSuccess;
			}
		}

		private function prepareActorForRemoval(index:int):void{
			
			if(!_registeredActors || !_registeredActors[index])
				return;
			
			ActorState(_registeredActors[index]).actor.beforeRemove();
			
		}


		private function filterMessage(messageFilter:FacadeMessageFilter = null, 
									   flattenendMessageGroups:String = null, 
									   flattenedMessageTypes:String = null,
									   useStrictFilter:Boolean=false):Boolean {

			var messageGroup:String;
			var messageType:String; 
			
			try
			{
				// Determine if message filter is empty
				const isEmptyFilter:Boolean = FacadeMessageFilter.isEmpty(messageFilter);
				
				// If empty filter types/groups and strict filter enabled, return true(filter result)
				if (isEmptyFilter && useStrictFilter)
					return true;
				
				// Disregard filter if null - OR - groups/types are empty AND strict filter is false. 
				if(isEmptyFilter)
					return false;
				
				
				// Check message groups
				if (messageFilter.messageGroups && messageFilter.messageGroups.length > 0 && flattenendMessageGroups) {
					for each (var mGroup:String in messageFilter.messageGroups) {
						messageGroup = MESSAGE_SEPARATOR + mGroup + MESSAGE_SEPARATOR;
						if (flattenendMessageGroups.indexOf(messageGroup) >= 0)
							return false;
					}
				}
				
				// Check message types
				if (messageFilter.messageTypes && messageFilter.messageTypes.length > 0 && flattenedMessageTypes) {
					for each (var mType:String in messageFilter.messageTypes) {
						messageType = MESSAGE_SEPARATOR + mType + MESSAGE_SEPARATOR;
						if (flattenedMessageTypes.indexOf(messageType) >= 0)
							return false;
					}
				}
				
				return true;
			} 
			catch(error:Error) 
			{
				trace("filterMessage - error: " + error.getStackTrace());
			}
		
			return true;
			
		}
		
		public function getCommand(actorName:String, actorKey:String):ICommandActor
		{
			if(!isValidActorType(actorName, actorKey, ActorType.COMMAND))
				return null;
			
			return getRegisteredActor(actorName, actorKey) as ICommandActor;
			 
		}
		
		public function getMediator(actorName:String, actorKey:String):IMediatorActor
		{
			if(!isValidActorType(actorName, actorKey, ActorType.MEDIATOR))
				return null;
			
			return getRegisteredActor(actorName, actorKey) as IMediatorActor;
		}
		
		public function getModel(actorName:String):IModelActor
		{ 
			if(!isValidActorType(actorName, ModelActor.getModelActorKey(actorName), ActorType.MODEL))
				return null;
			
			return getRegisteredActor(actorName, ModelActor.getModelActorKey(actorName)) as IModelActor;
		}
		
		 
		private function getRegisteredActor(name:String, key:String):IFacadeActor {
			if (_registeredActors == null || _registeredActors.length == 0) {
				return null;
				trace("No actors are registered...");
			}

			for each (var actorState:ActorState in _registeredActors) {

				var actorUID:String = actorState.actor.actorName + actorState.actorKey;
				trace("ACTOR UID:", actorUID);
				if ((name + key) == actorUID) {
					//trace("Found mediator: " + mediatorUID);
					return actorState.actor;
				}
			}
			return null;
		}

		private function onDelayMessageComplete(e:TimerEvent):void {

			if (_delayTimer.TimerData is FacadeMessage)
				this.sendMessageObject(_delayTimer.TimerData as FacadeMessage);

			_delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onDelayMessageComplete);

		}

		// Check if messages should be filtered
		private function publishMessageToRegisteredActors(message:FacadeMessage):void {
			// Mediators
			try
			{
				for each (var actorState:ActorState in _registeredActors) {
					
					const useStrictFilter:Boolean = (!actorState.messageFilter) ? false : actorState.messageFilter.strictFilter;
					
					if (!filterMessage(message.messageFilter, 
						actorState.flattenendMessageGroups, 
						actorState.flattenendMessageTypes, 
						useStrictFilter)) {
						
						actorState.actor.handleFacadeMessage(message as IFacadeMessage);
						trace(message.messageId + " - " + actorState.actorKey + actorState.actor.actorName + ": message accepted");
					}
					 else
					trace(message.messageId + " - " + actorState.actorKey + actorState.actor.actorName + ": message filtered"); 
					
				}
			} 
			catch(error:Error) 
			{
				trace("publishMessageToRegisteredMembers - error: " + error.getStackTrace());
			}
			
		}

		private function searchRegisteredActors(name:String, key:String):Number {

			for (var i:int = 0; i < _registeredActors.length; i++) {
				var actorUID:String = _registeredActors[i].actor.actorName + _registeredActors[i].actorKey;
				if ((name + key) == actorUID) {
					//trace("Found mediator: " + mediatorUID);
					return i;
				}
			}

			return -1;
		}
		
		/**
		 * 
		 * @param command
		 * @param messageFilter
		 * @param messageDomain
		 */
		public function registerCommand(command:ICommandActor, 
										messageFilter:FacadeMessageFilter=null, 
										messageDomain:String=null ):void
		{
			if(!messageFilter)
				messageFilter = new FacadeMessageFilter(null, [command.actorName]);
			
			registerActor(command, messageFilter, messageDomain );
			
		}
		
		/**
		 * 
		 * @param mediator
		 * @param messageFilter
		 * @param messageDomain
		 */
		public function registerMediator(mediator:IMediatorActor, 
										 messageFilter:FacadeMessageFilter=null, 
										 messageDomain:String=null ):void
		{
			registerActor(mediator, messageFilter, messageDomain );
			
		}
		
		/**
		 * 
		 * @param model
		 * @param messageFilter
		 * @param messageDomain
		 */
		public function registerModel(model:IModelActor, 
									  messageFilter:FacadeMessageFilter=null, 
									  messageDomain:String=null ):void
		{
			if(!messageFilter)
				messageFilter = new FacadeMessageFilter(null, [model.actorName]);
			
			registerActor(model, messageFilter, messageDomain );
			
		}
		
		private function isValidActorType(actorName:String, actorKey:String, validActorType:ActorType):Boolean{
			
			const actor:IFacadeActor = getRegisteredActor(actorName, actorKey);
			
			if(!actor || actor.actorType != validActorType){
				
				trace("Actor does not exist or is not ", validActorType.value);
				
				return false;
			}
			
			return true;
		}
		
		/**
		 * 
		 * @param actorName
		 * @param actorKey
		 * @return 
		 */
		public function unRegisterCommand(actorName:String, actorKey:String):Boolean
		{
			if(!isValidActorType)
				return false;
			
			return unRegisterActor(actorName, actorKey);
		}
		
		/**
		 * 
		 * @param actorName
		 * @param actorKey
		 * @return 
		 */
		public function unRegisterMediator(actorName:String, actorKey:String):Boolean
		{
			if(!isValidActorType)
				return false;
			
			return unRegisterActor(actorName, actorKey);
		}
		
		/**
		 * 
		 * @param actorName 
		 * @return 
		 */
		public function unRegisterModel(actorName:String):Boolean
		{
			if(!isValidActorType)
				return false;
			
			return unRegisterActor(actorName, ModelActor.getModelActorKey(actorName));
		}
		
	}
}

/**
 * This is a private class declared outside of the package
 * that is only accessible to classes inside of the Model.as
 * file.  Because of that, no outside code is able to get a
 * reference to this class to pass to the constructor, which
 * enables us to prevent outside instantiation.
 */
class SingletonLock {
}
