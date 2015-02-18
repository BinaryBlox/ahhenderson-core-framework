package ahhenderson.core.managers.dependency.facadeService
{
	import mx.utils.UIDUtil;
	
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IAmfServiceFacadeDefinition;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IServiceDefinition;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IServiceRequest;

	public class AmfServiceRequest implements IServiceRequest
	{
		public function AmfServiceRequest(serviceDefinition:IAmfServiceFacadeDefinition, ... args)
		{ 
			_serviceDefinition=serviceDefinition;

			// Set rest params
			setArgs.apply(null, args);
			
			_key=UIDUtil.createUID();

		}

		private var _args:Array;
 
		private var _customWaitMessage:String;
		
		private var _key:String;

		private var _serviceDefinition:IAmfServiceFacadeDefinition;

		public function get customWaitMessage():String
		{
			return _customWaitMessage;
		}

		public function set customWaitMessage(value:String):void
		{
			_customWaitMessage = value;
		}

		public function get args():Array
		{
			return _args;
		}
 
		public function get isUpdateable():Boolean
		{
			return false;
		}

		public function get key():String
		{
			return _key;
		}

		public function get requestId():String
		{
			return _key;
		}

		public function get serviceDefinition():IServiceDefinition
		{
			return _serviceDefinition;
		}

		// Use when passing in rest parameters argument. 
		internal function setArgs(... args):void
		{
			_args=args;
		}
	}
}
