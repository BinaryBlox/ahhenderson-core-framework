package ahhenderson.core.managers.dependency.facadeService
{
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	
	public class PendingModalServiceResult implements IDictionaryItem
	{
		public function PendingModalServiceResult(key:String)
		{
			
			_key = key;
			
		}
		
		private var _key:String;
		
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