package ahhenderson.core.util
{
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	
	import flash.utils.ByteArray;

	public class EncryptionUtil
	{

		public static function decryptData(dataIn:String, passphrase:String, iv:String, format:String=null):String
		{

			// 1: get a key
			var k:String=passphrase;
			var kdata:ByteArray;
			var kformat:String="hex";
			var returnValue:String;

			switch (kformat)
			{
				case "hex":
					kdata=Hex.toArray(k) as ByteArray;
					break;
				case "b64":
					kdata=Base64.decodeToByteArray(k) as ByteArray;
					break;
				default:
					kdata=Hex.toArray(Hex.fromString(k)) as ByteArray;
			}

			// 2: get an output
			var txt:String=dataIn;
			var data:ByteArray;
			format=String("b64");
			switch (format)
			{
				case "hex":
					data=Hex.toArray(txt) as ByteArray;
					break;
				case "b64":
					data=Base64.decodeToByteArray(txt) as ByteArray;
					break;
				default:
					data=Hex.toArray(Hex.fromString(txt)) as ByteArray;
			}
/*
			// FIX LATER
			// 3: get an algorithm..
			var name:String="blowfish-cbc";
			var pad:IPad=new NullPad;
			var mode:ICipher=Crypto.getCipher(name, kdata, pad);
			pad.setBlockSize(mode.getBlockSize());

			// 4: User IV
			if (mode is IVMode)
			{
				var ivmode:IVMode=mode as IVMode;
				ivmode.IV=Hex.toArray(iv);
			}

			// 5: Decrypt 
			mode.decrypt(data);

			// 6: Decode
			switch (format)
			{
				//case "hex":
				//	returnValue=Hex.fromArray(data);
				//	break;
				//case "b64":
				//	returnValue=Base64.encodeByteArray(data);
				//	break; 
				default:
					returnValue=Hex.toString(Hex.fromArray(data));
					break;
			}*/

			return returnValue;
		}

		public function EncryptionUtil()
		{
		}
	}
}
