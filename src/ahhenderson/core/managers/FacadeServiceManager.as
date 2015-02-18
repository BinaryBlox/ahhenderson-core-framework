//------------------------------------------------------------------------------
//
// Kaiser Permanente Organization,  Copyright 2012  
// All rights reserved.  
//
//------------------------------------------------------------------------------

package ahhenderson.core.managers{
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.UIDUtil;
	
	import ahhenderson.core.collections.DictionaryList;
	import ahhenderson.core.managers.dependency.facadeService.AmfServiceRequest;
	import ahhenderson.core.managers.dependency.facadeService.FacadeServiceConfiguration;
	import ahhenderson.core.managers.dependency.facadeService.FacadeServiceResponder;
	import ahhenderson.core.managers.dependency.facadeService.PendingModalServiceResult;
	import ahhenderson.core.managers.dependency.facadeService.ServiceRequestGroup;
	import ahhenderson.core.managers.dependency.facadeService.constants.FacadeErrorConstants;
	import ahhenderson.core.managers.dependency.facadeService.events.FacadeServiceManagerEvent;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IAmfServiceFacadeDefinition;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IHttpServiceFacadeDefinition;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IServiceDefinition;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IServiceRequest;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;
	import ahhenderson.core.mvc.patterns.facade.GlobalFacade;
	
	 
	
	[Event(name = "facadeServiceManagerEvent", type = "ahhenderson.core.managers.dependency.facadeService.events.FacadeServiceManagerEvent")]  
	public class FacadeServiceManager extends EventDispatcher {
		
		/**
		 * 
		 * @default 
		 */
		public static const DEFAULT_LOADING_MESSAGE:String = "Loading data...";
		
		/**
		 * 
		 * @default 
		 */
		public static const DEFAULT_LOADING_TITLE:String = "Please wait";
		
		/**
		 * 
		 * @default 
		 */
		public static const REQUEST_TIMEOUT:int = 15000;
		
		private static const _instance:FacadeServiceManager = new FacadeServiceManager( SingletonLock );
		
		private function get dialogMessage():Object
		{
			if(!_dialogMessage)
				_dialogMessage = new Object();
			
			return _dialogMessage;
		}

		/**
		 *
		 * @return
		 */
		public static function get instance():FacadeServiceManager {
			
			return _instance;
		}
		
		/**
		 *
		 * @param lock
		 * @throws Error
		 */
		public function FacadeServiceManager( lock:Class ) {
			
			if ( lock != SingletonLock ) {
				throw new Error( "Invalid Singleton access.  Use Model.instance." );
			}
			
			// Initialization
			_facade = GlobalFacade.instance;
		}
		
		internal var _pendingModalServiceResults:DictionaryList = new DictionaryList();
		
		internal var _registeredServiceConfigurations:DictionaryList = new DictionaryList();
		
		internal var _registeredServiceRequestGroups:DictionaryList = new DictionaryList();
		
		private var _facade:GlobalFacade;
		
		/**
		 * 
		 * @param serviceConfigKey
		 * @param groupKey
		 * @param serviceRequests
		 * @param resultNotificationId
		 * @param faultNotificationId
		 * @param modalWait
		 * @param loadingMessage
		 * @throws Error
		 */
		public function invokeAMFGroupedServicesCall( serviceConfigKey:String, groupKey:String, serviceRequests:Vector.<AmfServiceRequest>,
													  resultNotificationId:String, faultNotificationId:String, modalWait:Boolean = true,
													  loadingMessage:String = DEFAULT_LOADING_MESSAGE ):void {
			
			trace( "DEBUG: ", "invokeAMFGroupedServicesCall ", "groupKey: ", groupKey );
			
			if ( !serviceRequests || serviceRequests.length == 0 )
				throw new Error( FacadeErrorConstants.SERVICE_REQUEST_INVALID );
			
			const serviceRequestItems:DictionaryList = new DictionaryList();
			
			for ( var i:int = 0; i < serviceRequests.length; i++ )
				serviceRequestItems.addItem( serviceRequests[ i ]);
			
			const serviceRequestGroupItem:ServiceRequestGroup =
				new ServiceRequestGroup( serviceConfigKey,
					groupKey,
					serviceRequestItems,
					resultNotificationId,
					faultNotificationId,
					modalWait,
					loadingMessage );
			
			// Register service group
			_registeredServiceRequestGroups.addItem( serviceRequestGroupItem );
			
			// Execute all services within group
			invokeServiceRequestGroupCalls( serviceRequestGroupItem );
			
		}
		
		/**
		 * 
		 * @param serviceConfigKey
		 * @param serviceDefinition
		 * @param args
		 */
		public function invokeAMFServiceCall( serviceConfigKey:String, serviceDefinition:IAmfServiceFacadeDefinition, ... args ):void {
			
			trace( "DEBUG: ", "invokeAMFServiceCall ", "service: ", serviceDefinition.value );
			
			// Call base, internal method which handles grouped service calls
			invokeAMFServiceBaseMethod.apply( null, [ serviceConfigKey, serviceDefinition, UIDUtil.createUID(), null ].concat( args ));
			
		}
		
		/**
		 * 
		 * @param serviceConfigKey
		 * @param serviceRequest
		 * @param args
		 * @throws Error
		 */
		public function invokeHTTPService( serviceConfigKey:String, serviceRequest:IHttpServiceFacadeDefinition, ... args ):void {
			
			throw new Error( "FacadeServiceManager invokeHTTPService method is not implemented yet." );
			
		}
		
		public function serviceConfigurationExists(key:String):Boolean{
			
			return _registeredServiceConfigurations.itemExists(key);
		}
		
		/**
		 * 
		 * @param configuration
		 * @throws Error - FacadeErrorConstants.SERVICE_CONFIGURATION_IS_EMPTY
		 */
		public function registerServiceConfiguration( configuration:FacadeServiceConfiguration):void {
			
			// Service group was not found.
			if ( !configuration  )
				throw new Error( FacadeErrorConstants.SERVICE_CONFIGURATION_IS_EMPTY );
			
			// If registration already exists with same Id, it will be overriden with subsequent registrations
			_registeredServiceConfigurations.addItem( configuration);
		}
		
		/**
		 * 
		 * @param key
		 * @throws Error - FacadeErrorConstants.FACADE_SERVICE_CONFIG_KEY_ERROR_MSG
		 */
		public function unRegisterServiceConfiguration( key:String):void {
			
			// Key was empty
			if ( !key  )
				throw new Error( FacadeErrorConstants.FACADE_SERVICE_CONFIG_KEY_ERROR_MSG );
			
			// If registration already exists with same Id, it will be overriden with subsequent registrations
			_registeredServiceConfigurations.removeItem(key);
		}
		
		/**
		 * 
		 * @param key
		 * @throws Error - FacadeErrorConstants.FACADE_SERVICE_CONFIG_KEY_ERROR_MSG
		 */
		public function getServiceConfiguration( key:String):FacadeServiceConfiguration {
			
			// Key was empty
			if ( !key  )
				throw new Error( FacadeErrorConstants.FACADE_SERVICE_CONFIG_KEY_ERROR_MSG );
			
			// If registration already exists with same Id, it will be overriden with subsequent registrations
			return _registeredServiceConfigurations.getItem(key) as FacadeServiceConfiguration;
		}
		
		private var _dialogMessage:Object;
		
		internal function addPendingModalResult( itemKey:String, waitDialogTitle:String = DEFAULT_LOADING_TITLE, waitDialogMessage:String =
												 DEFAULT_LOADING_MESSAGE ):void {
			
			trace( "DEBUG: ", "addPendingModalResult ", "itemKey: ", itemKey );
			dialogMessage.title = (waitDialogTitle) ? waitDialogTitle : DEFAULT_LOADING_TITLE;
			dialogMessage.message = waitDialogMessage;
			
			dispatchEvent(new FacadeServiceManagerEvent(FacadeServiceManagerEvent.SHOW_DIALOG, dialogMessage));
				
			 
			_pendingModalServiceResults.addItem( new PendingModalServiceResult( itemKey ));
			
		}
		
		internal function dequeueServiceRequestFromGroup( serviceConfigKey:String, groupKey:String, serviceDefinition:IAmfServiceFacadeDefinition,
														  requestId:String, result:* = null ):void {
			
			trace( "DEBUG: ", "dequeueServiceRequestFromGroup ", "groupKey: ", groupKey, " requestId: ", requestId );
			
			const serviceRequestGroup:ServiceRequestGroup = _registeredServiceRequestGroups.getItem( groupKey ) as ServiceRequestGroup;
			
			// Service group was not found.
			if ( !serviceRequestGroup || !serviceRequestGroup.serviceRequestItems )
				throw new Error( FacadeErrorConstants.SERVICE_REQUEST_GROUP_DOES_NOT_EXIST );
			
			// Service request was not found in group
			if ( !serviceRequestGroup.serviceRequestItems.itemExists( requestId ))
				throw new Error( FacadeErrorConstants.SERVICE_REQUEST_GROUP_REQUEST_DOES_NOT_EXIST );
			
			// Add result to service group
			serviceRequestGroup.groupResult.addResult( serviceDefinition, result );
			
			// Remove service request from group.
			serviceRequestGroup.serviceRequestItems.removeItem( requestId );
			
			// If service requests still exist in group, we're not finished, return.
			if ( serviceRequestGroup.serviceRequestItems.items.length > 0 ) {
				
				// Update Service group (add acts as update when item is updateable)
				_registeredServiceRequestGroups.addItem( serviceRequestGroup )
				return;
			}
			
			//*************************************************************
			// No items left in the ServiceRequestGroup, remove the ServiceRequestGroup from the registered ServiceRequestGroup(s)
			// and package/send notification with group results
			//*************************************************************
			
			// Remove dialog message if applicable 
			if ( serviceRequestGroup.modalWait )
				removePendingWaitResultItem( groupKey );
			
			_registeredServiceRequestGroups.removeItem( groupKey );
			
			
			// Send out notifications to component
			_facade.sendMessage(serviceRequestGroup.resultNotificationId, serviceRequestGroup.groupResult, new FacadeMessageFilter([serviceConfigKey]));
			 
		}
		
		internal function handleServiceRequestGroupFault( groupKey:String, serviceDefinition:IServiceDefinition, event:FaultEvent ):void {
			
			const serviceRequestGroup:ServiceRequestGroup = _registeredServiceRequestGroups.getItem( groupKey ) as ServiceRequestGroup;
			
			// Service group was not found or removed from subsequent fault
			if ( !serviceRequestGroup || !serviceRequestGroup.serviceRequestItems ) {
				 
				dispatchEvent(new FacadeServiceManagerEvent(FacadeServiceManagerEvent.HIDE_DIALOG));
				
				return; 
			}
			
			// Remove dialog message if applicable 
			if ( serviceRequestGroup.modalWait )
				removePendingWaitResultItem( groupKey );
			
			_registeredServiceRequestGroups.removeItem( groupKey );
			
			// Send out notification to component(s)
			_facade.sendMessage(serviceRequestGroup.faultNotificationId, event, new FacadeMessageFilter([serviceRequestGroup.serviceConfigKey]));
			
			 
			
		}
		
		internal function invokeAMFServiceBaseMethod( serviceConfigKey:String, serviceDefinition:IAmfServiceFacadeDefinition, requestId:String = null,
													  groupKey:String = null, ... args ):void {
			
			try {
				
				if ( !serviceConfigKey )
					throw new Error( FacadeErrorConstants.FACADE_KEY_ERROR_MSG );
				
				if ( !_registeredServiceConfigurations.itemExists( serviceConfigKey ))
					throw new Error( FacadeErrorConstants.FACADE_NOT_REGISTERED_ERROR_MSG );
				
				var config:FacadeServiceConfiguration = _registeredServiceConfigurations.getItem( serviceConfigKey ) as FacadeServiceConfiguration;
				
				// Reuse remote object.
				config.remoteObject.requestTimeout = config.timeout;
				config.remoteObject.destination = ( serviceDefinition.destination ) ? serviceDefinition.destination : config.destination;
				config.remoteObject.source = ( serviceDefinition.source ) ? serviceDefinition.source : config.source;
				config.remoteObject.endpoint = ( serviceDefinition.endpoint ) ? serviceDefinition.endpoint : config.endpoint;
				
				const asyncToken:AsyncToken = config.remoteObject[ serviceDefinition.methodName ].send.apply( null, args );
				
				// Create unique request ID (if not provided)
				if ( !requestId )
					requestId = UIDUtil.createUID();
				
				//  Add Modal wait (blocking) here  
				if ( !useServiceGroupWaitMessage( groupKey ))
					addPendingModalResult( requestId, null, serviceDefinition.modalWaitMessage );
				
				// Send service with custom responder
				asyncToken.addResponder( new FacadeServiceResponder( onAmfServiceResult,
					onAmfServiceFault,
					serviceConfigKey,
					serviceDefinition,
					requestId,
					groupKey ));
				
				LoggingManager.instance.trace(serviceDefinition, "invokeAMFServiceBaseMethod service: " + serviceDefinition.value + " groupKey: ", groupKey);
				//trace( "DEBUG: ", "invokeAMFServiceBaseMethod ", "service: ", serviceDefinition.value, " groupKey: ", groupKey );
				
			} catch ( e:Error ) {
				
				// Todo: Might handle with custom message and log here.
				throw e;
			}
		}
		
		internal function invokeServiceRequestGroupCalls( serviceGroup:ServiceRequestGroup ):void {
			
			LoggingManager.instance.trace(this, "invokeServiceRequestGroupCalls groupKey: " + serviceGroup.key);
			//trace( "DEBUG: ", "invokeServiceRequestGroupCalls ", "groupKey: ", serviceGroup.key );
			
			var request:IServiceRequest;
			
			// App wait (blocking)
			if ( serviceGroup.modalWait )
				addPendingModalResult( serviceGroup.key, null, serviceGroup.modalWaitMessage );
			
			for ( var i:int = 0; i < serviceGroup.serviceRequestItems.items.length; i++ ) {
				request = serviceGroup.serviceRequestItems.items[ i ] as IServiceRequest;
				
				// TODO: Check for AMF or HTTP service request here. 
				
				invokeAMFServiceBaseMethod.apply( null,
					[ serviceGroup.serviceConfigKey, request.serviceDefinition, request.requestId,
						serviceGroup.key ].concat( request.args ));
			}
		}
		
		// Service Fault
		internal function onAmfServiceFault( event:FaultEvent, serviceConfigKey:String, serviceDefinition:IAmfServiceFacadeDefinition, requestId:String,
											 serviceGroupKey:String = null ):void {
			
			trace( "DEBUG: ",
				"onAmfServiceFault ",
				"serviceDefinition: ",
				serviceDefinition.value,
				" groupKey: ",
				serviceGroupKey,
				" Filter: " +  serviceConfigKey,
				" fault: ",
				event.fault.faultString );
			
			if ( serviceGroupKey ) {
				handleServiceRequestGroupFault( serviceGroupKey, serviceDefinition, event );
				
				return;
			}
			
			// for single requests only
			removePendingWaitResultItem( requestId );
			
			// Send out notification to component(s)
			_facade.sendMessage(serviceDefinition.faultNotificationId, event.fault.faultString,  new FacadeMessageFilter([serviceConfigKey]));
			 
			
		}
		
		// Service Result
		internal function onAmfServiceResult( event:ResultEvent, serviceConfigKey:String, serviceDefinition:IAmfServiceFacadeDefinition,
											  requestId:String, serviceGroupKey:String = null ):void {
			
			//trace( "DEBUG: ", "onAmfServiceResult ", "serviceDefinition: ", serviceDefinition.value, " groupKey: ", serviceGroupKey, " serviceConfigKey: " +  serviceConfigKey);
			
			LoggingManager.instance.trace(this, "onAmfServiceResult serviceDefinition: " + serviceDefinition.value + " groupKey: " + serviceGroupKey + " serviceConfigKey: " +  serviceConfigKey);
			
			if ( serviceGroupKey ) {
				dequeueServiceRequestFromGroup( serviceConfigKey, serviceGroupKey, serviceDefinition, requestId, event.result );
				
				// Send out notification for individual calls in grouped call (to allow for individual delegation).
				if(serviceDefinition.alwaysSendNotification){ 
					_facade.sendMessage(serviceDefinition.resultNotificationId, event.result,  new FacadeMessageFilter([serviceConfigKey]));				
				}
				 
				return;
			}
			
			// for single requests only
			removePendingWaitResultItem( requestId );
			 
			// Send out notification to component(s) 
			_facade.sendMessage(serviceDefinition.resultNotificationId, event.result,  new FacadeMessageFilter([serviceConfigKey]));
			
			
		 
		}
		
		// Service Fault
		internal function onHttpServiceFault( event:FaultEvent ):void {
			
		}
		
		// Service Result
		internal function onHttpServiceResult( event:ResultEvent ):void {
			
		}
		
		internal function removePendingWaitResultItem( key:String ):void {
			
			_pendingModalServiceResults.removeItem( key );
			
			if ( _pendingModalServiceResults.items.length == 0 ){
				 
				dispatchEvent(new FacadeServiceManagerEvent(FacadeServiceManagerEvent.HIDE_DIALOG));
			}
				
			
		}
		
		internal function useServiceGroupWaitMessage( groupKey:String ):Boolean {
			
			trace( "DEBUG: ", "useServiceGroupWaitMessage ", "groupKey: ", groupKey );
			
			if ( !groupKey )
				return false;
			
			const serviceRequestGroup:ServiceRequestGroup = _registeredServiceRequestGroups.getItem( groupKey ) as ServiceRequestGroup;
			
			if ( !serviceRequestGroup || serviceRequestGroup.modalWait == false )
				return false;
			
			return true;
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
