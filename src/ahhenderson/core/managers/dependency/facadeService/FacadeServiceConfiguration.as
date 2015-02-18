package ahhenderson.core.managers.dependency.facadeService
{
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import ahhenderson.core.collections.interfaces.IDictionaryItem;

	/**
	 * 
	 * @author E283476
	 */
	public class FacadeServiceConfiguration implements IDictionaryItem
	{


		public static const REQUEST_TIMEOUT:int = 15000;

		/**
		 * 
		 * @param key
		 * @param destination
		 * @param endPoint
		 * @param source
		 * @param modalWait
		 * @param isUpdateable
		 */
		public function FacadeServiceConfiguration(key:String=null, 
												   destination:String=null, 
												   endPoint:String=null,
												   securityPolicyUrl:String=null,
												   source:String=null,
												   timeout:int=REQUEST_TIMEOUT,
												   modalWait:Boolean=true, 
												   isUpdateable:Boolean=true)
		{

			_key=key
			_destination = destination;
			_endpoint = endPoint;
			_securityPolicyUrl = securityPolicyUrl;
			_source = source;
			_timeout = timeout;
			_modalWait=modalWait;
			_isUpdateable=isUpdateable;  
		
			
		}
		
		private var _destination:String;
		
		private var _endpoint:String;
		
		private var _isUpdateable:Boolean;

		private var _key:String;

		private var _modalWait:Boolean;
		
		private var _remoteObject:RemoteObject;
		
		private var _securityPolicyUrl:String
		
		private var _source:String

		private var _timeout:int;

		public function get destination():String
		{
			return _destination;
		}

		public function set destination(value:String):void
		{
			if(_destination !== value){
				_destination = value;
			}
			
		}

		public function get endpoint():String
		{
			return _endpoint;
		}

		public function set endpoint(value:String):void
		{
			if(_endpoint !== value){
				_endpoint = value;
			}
			
		}

		/**
		 * 
		 * @return 
		 */
		public function get isUpdateable():Boolean
		{
			return _isUpdateable;
		}

		/**
		 * 
		 * @return 
		 */
		public function get key():String
		{
			return _key;
		}

		public function get modalWait():Boolean
		{
			return _modalWait;
		}

		public function set modalWait(value:Boolean):void
		{
			_modalWait = value;
		}

		public function get remoteObject():RemoteObject
		{
			
			if(!_remoteObject)
				_remoteObject = new RemoteObject();
			
			/*_remoteObject.source = this.source;
			_remoteObject.destination = this.destination;
			_remoteObject.requestTimeout = this.timeout;*/
				
			return _remoteObject;
		}

		public function get securityPolicyUrl():String
		{
			return _securityPolicyUrl;
		}

		public function set securityPolicyUrl(value:String):void
		{
			_securityPolicyUrl = value;
		}

		public function get source():String
		{
			return _source;
		}

		public function set source(value:String):void
		{
			if(_source !== value){
				_source = value;
			}
			
		}

		public function get timeout():int
		{
			return _timeout;
		}

		public function set timeout(value:int):void
		{
			_timeout = value;
		}
	}
}
