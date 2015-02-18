package ahhenderson.core.managers.dependency.facadeService
{
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IServiceDefinition;
	
	public class ServiceResult implements IDictionaryItem
	{
		public function ServiceResult(serviceDefinition:IServiceDefinition, result:*=null)
		{
			_key = serviceDefinition.value;
			_result = result;
		}
		
		private var _key:String;
		private var _result:*;
		
		public function get result():*
		{
			return _result;
		}

		public function get isUpdateable():Boolean
		{
			return false;
		}
		
		public function get key():String
		{
			return _key;
		}
	}
}