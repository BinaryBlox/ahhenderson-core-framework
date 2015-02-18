package ahhenderson.core.managers.dependency.facadeService
{
	import flash.utils.getTimer;
	
	import mx.utils.UIDUtil;
	
	import ahhenderson.core.collections.DictionaryList;
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IServiceNotification;

	public class ServiceRequestGroup implements IDictionaryItem, IServiceNotification
	{
		
		public static const DEFAULT_LOADING_MESSAGE:String="Loading...";
		
		public function ServiceRequestGroup(serviceConfigKey:String, 
												groupKey:String, 
												serviceRequestItems:DictionaryList, 
												resultNotificationId:String, 
												faultNotificationId:String,
												modalWait:Boolean=true, 
												modalWaitMessage:String=DEFAULT_LOADING_MESSAGE)
		{
 
			_key= groupKey + "_" + UIDUtil.createUID(); 
			
			_serviceRequestItems = serviceRequestItems;
			_resultNotificationId = resultNotificationId;
			_faultNotificationId = faultNotificationId;
			_requestStart=getTimer();
			_serviceConfigKey=serviceConfigKey;
			_modalWait = modalWait;
			_modalWaitMessage = modalWaitMessage;
		}

		private var _faultNotificationId:String;

		private var _serviceRequestItems:DictionaryList;
		  
		private var _key:String;

		private var _serviceConfigKey:String;
		
		private var _requestEnd:int;

		private var _requestStart:int;

		private var _resultNotificationId:String;
		
		private var _modalWait:Boolean;
		
		private var _modalWaitMessage:String;
		
		private var _groupResult:ServiceRequestGroupResult;
		

		public function get groupResult():ServiceRequestGroupResult
		{
			
			if(!_groupResult)
				_groupResult = new ServiceRequestGroupResult();
			
			return _groupResult;
		}

		public function get modalWaitMessage():String
		{
			return _modalWaitMessage;
		}

		public function get modalWait():Boolean
		{
			return _modalWait;
		}

		public function get serviceConfigKey():String
		{
			return _serviceConfigKey;
		}

		public function get serviceRequestItems():DictionaryList
		{
			return _serviceRequestItems;
		}

		public function get faultNotificationId():String
		{
			return _faultNotificationId;
		}
 
		public function get isUpdateable():Boolean
		{ 
			return true;
		}

		public function get key():String
		{
			return _key;
		}


		public function get requestStart():int
		{
			return _requestStart;
		}

		public function get resultNotificationId():String
		{
			return _resultNotificationId;
		}
	}
}
