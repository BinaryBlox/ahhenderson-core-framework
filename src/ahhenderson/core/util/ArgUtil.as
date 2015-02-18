//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.util {
	import ahhenderson.core.util.dependency.arg.Arg;
	public class ArgUtil {


		public static function argExists(key:String, arguments:Vector.<Arg>):Boolean {

			if(!arguments)
				return false;
			
			for (var i:int = 0; i < arguments.length; i++) {
				if (arguments[i].key == key)
					return true;
			}

			return false;
		}


		public static function getArg(key:String, arguments:Vector.<Arg>):Arg {
			
			if(!arguments)
				return null;
			
			for (var i:int = 0; i < arguments.length; i++) {
				if (arguments[i].key == key)
					return arguments[i];
			}

			return null;
		}
		
		public static function getValue(key:String, arguments:Vector.<Arg>):* {
			
			if(!arguments)
				return null;
			
			for (var i:int = 0; i < arguments.length; i++) {
				if (arguments[i].key == key)
					return arguments[i].value;
			}
			
			return null;
		}
	}
}
