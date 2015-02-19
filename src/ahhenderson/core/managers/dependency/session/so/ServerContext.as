
package ahhenderson.core.managers.dependency.session.so {
	import flash.system.Capabilities;
	
	import ahhenderson.core.collections.DictionaryBuilder;
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	import ahhenderson.core.managers.dependency.device.constants.PlatformConstants;
	import ahhenderson.core.managers.dependency.session.enums.ServerCapabilitiesTypeEnum;

	public class ServerContext {

		public function ServerContext() {

			setCapabilities();
		}

		public var applicationDPI:Number;
		
		public var amfServerUrl:String;

		public var backupAmfServerUrl:String;

		public var backupHttpServerUrl:String;

		public var backupMediaServerUrl:String;

		public var backupMulticastServerUrl:String;

		public var backupRtmpServerUrl:String;

		public var clientOS:String;

		public var httpServerUrl:String;

		public var mediaServerUrl:String;

		public var multicastServerUrl:String;

		public var rtmpServerUrl:String;

		private var _capbilities:String;

		private var _serverCapabilities:Vector.<IDictionaryItem>;

		private function setCapabilities():void {

			_serverCapabilities=new Vector.<IDictionaryItem>();
			
			var tempArr:Array;
			var isMobile:Boolean;
			
			// Determine Device Type
			tempArr = Capabilities.version.split(" ");
			
			if(tempArr && tempArr.length > 0){
				
				var osKey:String = tempArr[0];
				
				switch(osKey)
				{
					case PlatformConstants.ANDROID:
					 
						isMobile = true;
						break;
					
					case PlatformConstants.IOS:
						
						isMobile = true;
						break;
					  
					default:
						isMobile = false;
						break; 
				} 
			}
			
			DictionaryBuilder.addItem(new ServerCapability(ServerCapabilitiesTypeEnum.IS_MOBILE.value, isMobile), _serverCapabilities);
				
		/*	var kvPairs:Array = value.split('&');
			var kvPair:Array;
			_serverCapabilities=new Vector.<IDictionaryItem>();
			_capbilities=value;

			if (!kvPairs) {
				trace("ServerContextSO: No capabilities detected.");
				return;
			}

			for each (var item:String in kvPairs) {
				kvPair=item.split('=');

				if (kvPair && kvPair.length > 0)
					CustomDictionary.addItem(new ServerCapabilitySO(kvPair[0], kvPair[1]), _serverCapabilities);

			}*/
		}


		public function getCapability(capability:ServerCapabilitiesTypeEnum):* {

			return DictionaryBuilder.getItem(capability.value, _serverCapabilities) as String;

		}
	}
}

