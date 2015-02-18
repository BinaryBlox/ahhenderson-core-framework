package ahhenderson.core.managers.dependency.facadeService
{
	import ahhenderson.core.util.GuidUtil;
	
	public class AmfServiceRequestGroup
	{
		/**
		 *  
		 * @param amfServiceRequests
		 * @param resultNotificationId
		 * @param faultNotificationId
		 * @param customGroupKey
		 * @param modalWait
		 * @param modalWaitMessage
		 */
		public function AmfServiceRequestGroup(amfServiceRequests:Vector.<AmfServiceRequest>, 
											   resultNotificationId:String, 
											   faultNotificationId:String, 
											   customGroupKey:String=null, 
											   modalWait:Boolean=true,  
											   modalWaitMessage:String="Loading...")
		{
			 
			_resultNotificationId = resultNotificationId;
			_faultNotificationId = faultNotificationId;
			_modalWait = modalWait;
			_modalWaitMessage = modalWaitMessage;
			_amfServiceRequests = amfServiceRequests;
			
			// Generate a group key if not provided.
			_groupKey = (customGroupKey) ? customGroupKey: generateGroupKey();
		}

		private var _amfServiceRequests:Vector.<AmfServiceRequest>;

		private var _groupKey:String;
		
		private var _faultNotificationId:String;

		private var _modalWait:Boolean;

		private var _modalWaitMessage:String;

		private var _resultNotificationId:String;

		public function get groupKey():String
		{
			return _groupKey;
		}

		private function generateGroupKey():String{
			
			var generatedKey:String = "SVC_GROUP_REQ_" + GuidUtil.createUID();
			
			for(var i:int=0;i<amfServiceRequests.length;i++){
				generatedKey+="-" + amfServiceRequests[i].serviceDefinition.value;
			}
			
			return generatedKey;
		}
		/**
		 * 
		 * @return 
		 */
		public function get amfServiceRequests():Vector.<AmfServiceRequest>
		{
			return _amfServiceRequests;
		}

		/**
		 * 
		 * @return 
		 */
		public function get faultNotificationId():String
		{
			return _faultNotificationId;
		}

		/**
		 * 
		 * @return 
		 */
		public function get modalWait():Boolean
		{
			return _modalWait;
		}


		/**
		 * 
		 * @return 
		 */
		public function get modalWaitMessage():String
		{
			return _modalWaitMessage;
		}

		/**
		 * 
		 * @return 
		 */
		public function get resultNotificationId():String
		{
			return _resultNotificationId;
		}
	}
}
