
package ahhenderson.core.managers.dependency.device.enums{
 
	public final class SuspendModeTypeEnum
	{
		
		public static const AUTO:SuspendModeTypeEnum=new SuspendModeTypeEnum("smAuto");
		public static const ON:SuspendModeTypeEnum=new SuspendModeTypeEnum("smOn");
		public static const OFF:SuspendModeTypeEnum=new SuspendModeTypeEnum("smOff"); 
		
		private static var locked:Boolean=false;
		
		{
			locked=true;
		}
		
		public function SuspendModeTypeEnum(value:String):void
		{
			if (locked)
			{
				throw new Error("You can't instantiate SuspensionModeTypeEnum");
			}
			_value=value;
		}
		
		private var _value:String;
		
		public function get value():String
		{
			return _value;
		}
	}
}
