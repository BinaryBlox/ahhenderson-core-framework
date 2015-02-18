package ahhenderson.core.managers.dependency.facadeService.constants._deprecate
{
	import ahhenderson.core.managers.dependency.session.so.ServerContextSO;

	public class ServerConstants
	{
		public function ServerConstants()
		{
			
		}
		
		
		public static const AMF_SERVICES_URL:String="http://vizifitdev.cloudapp.net/Gateway.aspx"; 
		//public static const AMF_SERVICES_URL:String="http://cloud.vizifit.com/Gateway.aspx";
		
		//public static const AMF_SERVICES_URL:String="http://http://10.0.0.19/Gateway.aspx";
		
		//public static const AMF_SERVICES_URL:String="http://192.168.1.184/Gateway.aspx";
		 
		public static const FMS_MULTICAST_SERVER:String="rtmfp://69.94.134.21/multicast";	
		
		
			
		//public static const FMS_RTMP_SERVER:String="rtmp://ec2-54-235-224-102.compute-1.amazonaws.com/live/";
		//public static const FMS_RTMP_SERVER:String="rtmp://ec2-50-19-59-229.compute-1.amazonaws.com/live/";
		public static const FMS_RTMP_SERVER:String="rtmp://69.94.134.21/vizifitLive/";
		public static const UPDATE_URL:String="https://install.vizifit.com/config/update_1.1.xml";
		 
		
		public static function getServerContext():ServerContextSO{
			
			var serverContext:ServerContextSO = new ServerContextSO();
			
			serverContext.amfServerUrl = AMF_SERVICES_URL;
			serverContext.multicastServerUrl = FMS_MULTICAST_SERVER;
			serverContext.rtmpServerUrl = FMS_RTMP_SERVER;
			
			
			return serverContext;
		}
	}
}