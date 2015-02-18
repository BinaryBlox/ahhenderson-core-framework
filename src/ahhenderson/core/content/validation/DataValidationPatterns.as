package ahhenderson.core.content.validation
{
	public class DataValidationPatterns
	{
		public function DataValidationPatterns()
			{
			super();
		}
		
		public static const EXP_REGEX_USERNAME:String = "^[a-zA-Z0-9_.-]{6,30}$";
		public static const EXP_REGEX_PASSWORD:String = "^[a-zA-Z0-9_.-]{6,20}$";
		public static const EXP_REGEX_ALPHAN_TEXT_30:String = "^[a-zA-Z0-9_.-]{2,30}$";
		public static const EXP_REGEX_ALPHAN_TEXT_50:String = "^[a-zA-Z0-9_.-]{2,50}$";
		
		public static const RESTRICT_ALPHA_TEXT:String = "a-z A-Z";
		public static const RESTRICT_ADV_ALPHANUM_TEXT:String = "a-z A-Z 0-9 \\' \\! \\, \\. \\- \\_";
		public static const RESTRICT_EMAIL_TEXT:String = "a-z A-Z 0-9 \\@ \\. \\- \\_";
		
		public static const RESTRICT_PASSWORD_TEXT:String = "a-z A-Z 0-9 \\. \\- \\_";
		
		public static const MSG_REGEX_ALPHAN_TEXT_30:String = "Please enter (2-30) alphanumeric characters.";
		public static const MSG_REGEX_ALPHAN_TEXT_50:String = "Only (2-50) alphanumeric characters please...";
		public static const MSG_REGEX_USERNAME:String = "Please try again.\nOnly (6-20) alphanumeric characters allowed.";
		public static const MSG_REGEX_PASSWORD:String = "Please try again.\nOnly (6-20) alphanumeric characters allowed.";
		
		public static const EXP_REGEX_EMAIL:String = "^([a-zA-Z0-9]+[a-zA-Z0-9._%-]*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,4})$";

	}
}