package ahhenderson.core.managers.dependency.facadeService.base {

	import ahhenderson.core.managers.dependency.facadeService.interfaces.IAmfServiceFacadeDefinition;


	public class AbstractServiceFacadeDefinition implements IAmfServiceFacadeDefinition {

		/**
		 * <p><b>AbstractServiceFacadeDefinition</b><br>Service definitions for required for Booking startup/initialization</P>
		 * @param value - Key value for 'fake' enumeration type
		 * @param methodName - Service method name
		 * @param resultNotificationId - Custom result notification id(automatically set by default)
		 * @param faultNotificationId - Custom fault notification id(automatically set by default)
		 * @param endPoint - Custom endPoint (automatically defaulted by FacadeServicesManager)
		 * @param source - Custom source (automatically defaulted by FacadeServicesManager)
		 * @param destination - Custom destination (automatically defaulted by FacadeServicesManager)
		 */
		public function AbstractServiceFacadeDefinition( value:String, methodName:String, modalWaitMessage:String = "Loading...",
														 modalWait:Boolean = true, resultNotificationId:String = null,
														 faultNotificationId:String = null, destination:String = null, source:String = null,
														 endPoint:String = null, alwaysSendNotification:Boolean = true ):void

		{

			//this._value=PREFIX + "_" + value;
			this._value = value;
			this._methodName = methodName;
			this._modalWait = modalWait;
			this._modalWaitMessage = modalWaitMessage;
			this._resultNotificationId = resultNotificationId;
			this._faultNotificationId = faultNotificationId;
			this._source = source;
			this._endPoint = endPoint;
			this._destination = destination;
			this._alwaysSendNotification = alwaysSendNotification;
		}

		private var _destination:String;

		private var _endPoint:String;

		private var _faultNotificationId:String;

		private var _methodName:String;

		private var _modalWait:Boolean;

		private var _modalWaitMessage:String;

		private var _resultNotificationId:String;

		private var _source:String;

		private var _value:String;

		private var _requestId:String;

		private var _alwaysSendNotification:Boolean;

		
		
		/**
		 *
		 * Allow setting of the modal wait message
		 */
		public function set modalWaitMessage(value:String):void
		{
			_modalWaitMessage = value;
		}

		public function get alwaysSendNotification():Boolean {

			return _alwaysSendNotification;
		}

		public function get requestId():String {

			return _requestId;
		}

		public function set requestId( value:String ):void {

			_requestId = value;
		}

		/**
		 *
		 * @return
		 */
		public function get destination():String {

			return _destination;
		}

		/**
		 *
		 * @return
		 */
		public function get endpoint():String {

			return _endPoint;
		}

		/**
		 *
		 * @return
		 */
		public function get faultNotificationId():String {

			if ( !_faultNotificationId )
				_faultNotificationId = this.value + "_FAULT";

			return _faultNotificationId;
		}

		/**
		 *
		 * @return
		 */
		public function get methodName():String {

			return _methodName;
		}

		/**
		 *
		 * @return
		 */
		public function get modalWait():Boolean {

			return _modalWait;
		}

		public function get modalWaitMessage():String {

			return _modalWaitMessage;
		}

		/**
		 *
		 * @return
		 */
		public function get resultNotificationId():String {

			if ( !_resultNotificationId )
				_resultNotificationId = this.value + "_RESULT";

			return _resultNotificationId;
		}

		/**
		 *
		 * @return
		 */
		public function get source():String {

			return _source;
		}

		/**
		 *
		 * @return
		 */
		public function get value():String {

			return _value;
		}
	}
}

