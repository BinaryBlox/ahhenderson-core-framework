package ahhenderson.core.managers.dependency.facadeService.interfaces
{

	public interface IAmfServiceFacadeDefinition extends IServiceDefinition
	{

		function get destination():String;

		function get endpoint():String;
  
		function get methodName():String;

		function get modalWait():Boolean;

		function get modalWaitMessage():String;
  
		function get source():String;
		
		function get alwaysSendNotification():Boolean;
	}
}
