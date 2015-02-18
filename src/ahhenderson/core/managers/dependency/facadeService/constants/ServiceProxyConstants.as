package ahhenderson.core.managers.dependency.facadeService.constants
{
	public class ServiceProxyConstants
	{
		public function ServiceProxyConstants()
			{
			super();
		}
		
		public static const NOTE_SERVICE:String  					 	= 'ServiceNote';
		public static const NOTE_SERVICE_REMOTE:String  				= 'RemoteServiceNote';
		
		// Note for remoting service call (Flourine)
		public static const NOTETYPE_REMOTE_SERVICE_CALL:String  		= 'RemoteServiceCall';
		public static const NOTETYPE_REMOTE_SERVICE_CALL_RESULT:String  = 'RemoteServiceCallResult';
		
		// Note for HTTP Service Call
		public static const NOTETYPE_HTTPSERVICE_CALL:String  		 	= 'HttpServiceCall';
		public static const NOTETYPE_HTTPSERVICE_CALL_RESULT:String  	= 'HttpServiceCallResult';
	}
}