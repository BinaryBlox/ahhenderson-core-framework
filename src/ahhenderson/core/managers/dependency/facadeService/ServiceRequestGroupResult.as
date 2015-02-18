package ahhenderson.core.managers.dependency.facadeService
{
	import mx.collections.ArrayCollection;
	
	import ahhenderson.core.collections.DictionaryList;
	import ahhenderson.core.managers.dependency.facadeService.interfaces.IServiceDefinition;

	 
	public class ServiceRequestGroupResult
	{
		/**
		 * 
		 */
		public function ServiceRequestGroupResult()
		{
		}

		private var _resultList:DictionaryList;

		/**
		 * 
		 * @param service
		 * @param result
		 */
		public function addResult(service:IServiceDefinition, result:*=null):void
		{

			this.resultList.addItem(new ServiceResult(service, result));
		}

		/**
		 * 
		 * @return 
		 */
		public function getAllResults():ArrayCollection
		{

			return this.resultList.getItemsAsArrayCollection();
		}

		/**
		 * 
		 * @param service
		 */
		public function getResult(service:IServiceDefinition):*
		{
			if(!this.resultList.itemExists(service.value))
				return null;

			return (this.resultList.getItem(service.value) as ServiceResult).result;
		}

		internal function get resultList():DictionaryList
		{

			if (!_resultList)
				_resultList=new DictionaryList();

			return _resultList;
		}
	}
}
