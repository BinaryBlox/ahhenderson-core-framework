package ahhenderson.core.managers.dependency.facadeService.interfaces
{
	import ahhenderson.core.collections.interfaces.IDictionaryItem;

	public interface IServiceRequest extends IDictionaryItem 
	{
		function get args():Array;
		
		function get serviceDefinition():IServiceDefinition;
		
		function get requestId():String;
		
		function get customWaitMessage():String;
		 
	}
}