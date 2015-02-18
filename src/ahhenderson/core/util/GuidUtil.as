 

package  ahhenderson.core.util
{
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
  
	/**
	 *  The GUIDUtils class is an all-static class
	 *  with methods for working with UIDs (unique identifiers) within Flex.
	 *  You do not create instances of GUIDUtils;
	 *  instead you simply call static methods such as the
	 *  <code>GUIDUtils.createUID()</code> method.
	 * 
	 *  <p><b>Note</b>: If you have a dynamic object that has no  properties 
	 *  (which force the object to implement the IUID interface), Flex  adds an 
	 *  <code>mx_internal_uid</code> property that contains a UID to the object. 
	 *  To avoid having this field 
	 *  in your dynamic object, make it , implement the IUID interface
	 *  in the object class, or set a <coded>uid</coded> property with a value.</p>
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class GuidUtil
	{
	 
		
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  Char codes for 0123456789ABCDEF
		 */
		private static const ALPHA_CHAR_CODES:Array = [48, 49, 50, 51, 52, 53, 54, 
			55, 56, 57, 65, 66, 67, 68, 69, 70];
		
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------
		
		/** 
		 *  This Dictionary records all generated uids for all existing items.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		private static var uidDictionary:Dictionary = new Dictionary(true);
		
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Generates a UID (unique identifier) based on ActionScript's
		 *  pseudo-random number generator and the current time.
		 *
		 *  <p>The UID has the form
		 *  <code>"XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"</code>
		 *  where X is a hexadecimal digit (0-9, A-F).</p>
		 *
		 *  <p>This UID will not be truly globally unique; but it is the best
		 *  we can do without player support for UID generation.</p>
		 *
		 *  @return The newly-generated UID.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function createUID():String
		{
			var uid:Array = new Array(36);
			var index:int = 0;
			
			var i:int;
			var j:int;
			
			for (i = 0; i < 8; i++)
			{
				uid[index++] = ALPHA_CHAR_CODES[Math.floor(Math.random() *  16)];
			}
			
			for (i = 0; i < 3; i++)
			{
				uid[index++] = 45; // charCode for "-"
				
				for (j = 0; j < 4; j++)
				{
					uid[index++] = ALPHA_CHAR_CODES[Math.floor(Math.random() *  16)];
				}
			}
			
			uid[index++] = 45; // charCode for "-"
			
			var time:Number = new Date().getTime();
			// Note: time is the number of milliseconds since 1970,
			// which is currently more than one trillion.
			// We use the low 8 hex digits of this number in the UID.
			// Just in case the system clock has been reset to
			// Jan 1-4, 1970 (in which case this number could have only
			// 1-7 hex digits), we pad on the left with 7 zeros
			// before taking the low digits.
			var timeString:String = ("0000000" + time.toString(16).toUpperCase()).substr(-8);
			
			for (i = 0; i < 8; i++)
			{
				uid[index++] = timeString.charCodeAt(i);
			}
			
			for (i = 0; i < 4; i++)
			{
				uid[index++] = ALPHA_CHAR_CODES[Math.floor(Math.random() *  16)];
			}
			
			return String.fromCharCode.apply(null, uid);
		}
		
		/**
		 * Converts a 128-bit UID encoded as a ByteArray to a String representation.
		 * The format matches that generated by createUID. If a suitable ByteArray
		 * is not provided, null is returned.
		 * 
		 * @param ba ByteArray 16 bytes in length representing a 128-bit UID.
		 * 
		 * @return String representation of the UID, or null if an invalid
		 * ByteArray is provided.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function fromByteArray(ba:ByteArray):String
		{
			if (ba != null && ba.length >= 16 && ba.bytesAvailable >= 16)
			{
				var chars:Array = new Array(36);
				var index:uint = 0;
				for (var i:uint = 0; i < 16; i++)
				{
					if (i == 4 || i == 6 || i == 8 || i == 10)
						chars[index++] = 45; // Hyphen char code
					
					var b:int = ba.readByte();
					chars[index++] = ALPHA_CHAR_CODES[(b & 0xF0) >>> 4];
					chars[index++] = ALPHA_CHAR_CODES[(b & 0x0F)];
				}
				return String.fromCharCode.apply(null, chars);
			}
			
			return null;
		}
		
		/**
		 * A utility method to check whether a String value represents a 
		 * correctly formatted UID value. UID values are expected to be 
		 * in the format generated by createUID(), implying that only
		 * capitalized A-F characters in addition to 0-9 digits are
		 * supported.
		 * 
		 * @param uid The value to test whether it is formatted as a UID.
		 * 
		 * @return Returns true if the value is formatted as a UID.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function isUID(uid:String):Boolean
		{
			if (uid != null && uid.length == 36)
			{
				for (var i:uint = 0; i < 36; i++)
				{
					var c:Number = uid.charCodeAt(i);
					
					// Check for correctly placed hyphens
					if (i == 8 || i == 13 || i == 18 || i == 23)
					{
						if (c != 45)
						{
							return false;
						}
					}
						// We allow capital alpha-numeric hex digits only
					else if (c < 48 || c > 70 || (c > 57 && c < 65))
					{
						return false;
					}
				}
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * Converts a UID formatted String to a ByteArray. The UID must be in the
		 * format generated by createUID, otherwise null is returned.
		 * 
		 * @param String representing a 128-bit UID
		 * 
		 * @return ByteArray 16 bytes in length representing the 128-bits of the
		 * UID or null if the uid could not be converted.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function toByteArray(uid:String):ByteArray
		{
			if (isUID(uid))
			{
				var result:ByteArray = new ByteArray();
				
				for (var i:uint = 0; i < uid.length; i++)
				{
					var c:String = uid.charAt(i);
					if (c == "-")
						continue;
					var h1:uint = getDigit(c);
					i++;
					var h2:uint = getDigit(uid.charAt(i));
					result.writeByte(((h1 << 4) | h2) & 0xFF);
				}
				result.position = 0;
				return result;
			}
			
			return null;
		}
		
		
		
		/**
		 * Returns the decimal representation of a hex digit.
		 * @private
		 */
		private static function getDigit(hex:String):uint
		{
			switch (hex) 
			{
				case "A": 
				case "a":           
					return 10;
				case "B":
				case "b":
					return 11;
				case "C":
				case "c":
					return 12;
				case "D":
				case "d":
					return 13;
				case "E":
				case "e":
					return 14;                
				case "F":
				case "f":
					return 15;
				default:
					return new uint(hex);
			}    
		}
	}
	
}
