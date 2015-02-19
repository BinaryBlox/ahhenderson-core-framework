
package ahhenderson.core.managers.dependency.session.enums {


	public final class ServerCapabilitiesTypeEnum {


		/*public static const avHardwareDisable:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("AVD");

		public static const hasAccessibility:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("ACC");

		public static const hasAudio:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("A");

		public static const hasAudioEncoder:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("AE");

		public static const hasEmbeddedVideo:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("IME");

		public static const hasIME:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("AE");

		public static const hasMP3:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("MP3");

		public static const hasPrinting:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("PR");

		public static const hasScreenBroadcast:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("SB");

		public static const hasScreenPlayback:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("SP");

		public static const hasStreamingAudio:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("SA");

		public static const hasStreamingVideo:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("SV");

		public static const hasTLS:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("TLS");

		public static const hasVideoEncoder:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("VE");

		public static const isDebugger:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("DEB");

		public static const language:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("L");

		public static const localFileReadDisable:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("LFD");

		public static const manufacturer:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("M");

		public static const maxLevelIDC:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("ML");

		public static const os:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("OS");

		public static const pixelAspectRatio:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("AR");

		public static const PLAYER_TYPE:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("PT");

		public static const SCREEN_COLOR:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("COL");

		public static const SCREEN_DPI:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("DP");
  
		public static const SCREEN_RESOLUTION:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("R");

		public static const VERSION:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("V");
		*/
		public static const IS_MOBILE:ServerCapabilitiesTypeEnum=new ServerCapabilitiesTypeEnum("isMobile");



		private static var locked:Boolean=false;
		{
			locked=true;
		}


		public function ServerCapabilitiesTypeEnum(value:String):void {

			if (locked) {
				throw new Error("You can't instantiate value");
			}
			_value=value;
		}

		private var _value:String;


		public function get value():String {

			return _value;
		}
	}
}
