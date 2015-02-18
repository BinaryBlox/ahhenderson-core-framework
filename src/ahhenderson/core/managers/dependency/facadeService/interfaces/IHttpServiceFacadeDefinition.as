package ahhenderson.core.managers.dependency.facadeService.interfaces
{

	public interface IHttpServiceFacadeDefinition extends IServiceDefinition
	{

		function get destination():String;
  
		// POST should be default
		function get method():String;
  
		function get url():String;
	}
}
