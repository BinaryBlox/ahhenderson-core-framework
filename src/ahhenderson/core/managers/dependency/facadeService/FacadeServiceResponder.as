package ahhenderson.core.managers.dependency.facadeService
{
	import mx.rpc.IResponder;
	
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IAmfServiceFacadeDefinition;

	/**
	 *
	 * @author E283476
	 */
	public class FacadeServiceResponder extends Object implements IResponder
	{

		/**
		 *
		 * @param result
		 * @param fault
		 * @param facadeKey
		 * @param serviceRequest
		 */
		public function FacadeServiceResponder(result:Function, fault:Function, facadeKey:String, serviceDefinition:IAmfServiceFacadeDefinition, requestId:String, serviceGroupKey:String=null)
		{
			super();
			this._resultHandler=result;
			this._faultHandler=fault;
			this._facadeKey=facadeKey;
			this._serviceDefinition=serviceDefinition;
			this._requestId=requestId;
			this._serviceGroupKey=serviceGroupKey;
		}

		private var _facadeKey:String;

		private var _faultHandler:Function;

		private var _requestId:String;

		private var _resultHandler:Function;

		private var _serviceGroupKey:String;

		private var _serviceDefinition:IAmfServiceFacadeDefinition;

		/**
		 *
		 * @return
		 */
		public function get facadeKey():String
		{
			return _facadeKey;
		}

		/**
		 *
		 * @param info
		 */
		public function fault(info:Object):void
		{
			this._faultHandler(info, this.facadeKey, this.serviceDefinition, this.requestId, this.serviceGroupKey);
		}

		public function get requestId():String
		{
			return _requestId;
		}

		/**
		 *
		 * @param data
		 */
		public function result(data:Object):void
		{
			this._resultHandler(data, this.facadeKey, this.serviceDefinition, this.requestId, this.serviceGroupKey);
		}

		public function get serviceGroupKey():String
		{
			return _serviceGroupKey;
		}

		/**
		 *
		 * @return
		 */
		public function get serviceDefinition():IAmfServiceFacadeDefinition
		{
			return _serviceDefinition;
		}
	}
}
