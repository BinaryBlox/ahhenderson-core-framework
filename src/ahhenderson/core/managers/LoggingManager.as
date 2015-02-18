package ahhenderson.core.managers
{

	import com.demonsters.debugger.MonsterDebugger;
	
	


	public class LoggingManager 
	{

		private static const _instance:LoggingManager=new LoggingManager(SingletonLock);

		/**
		 *
		 * @return
		 */
		public static function get instance():LoggingManager
		{

			return _instance;
		}
		
		public function initialize(displayObject:*):void
		{ 
			// Start the MonsterDebugger with a Starling display object
			MonsterDebugger.initialize(displayObject);
			MonsterDebugger.trace(displayObject, "Starting Starling Application...");
			_isInitialized=true;
		}
		
		/**
		 * This is a copy of the classic Flash trace function 
		 * where you can supply a comma separated list of objects to trace. 
		 * It will call the MonsterDebugger.trace() function for every 
		 * object you supply in the arguments (... args). This can be useful
		 * when tracing multiple properties at once like: 
		 * MonsterDebugger.log(x, y, width, height). But it can also be handy 
		 * for tracing events as can be seen in the example.
		 
		 */
		public function log(...args):void{
			
			MonsterDebugger.log.apply(null, args);
		}
		
		/**
		 *
		 * @param caller:*
		 * @param object:*
		 * @param person:String
		 * @param label:String
		 * @param color:uint
		 * @depth int
		 * @throws Error
		 */
		public function trace(caller:*, object:*, person:String="", label:String="", color:uint=0, depth:int=5):void{
			
			MonsterDebugger.trace(caller, object, person, label, color, depth);
			 
		}
		
		/**
		 *
		 * @param caller:*
		 * @param id:String 
		 * @throws Error
		 */
		public function breakpoint(caller:*, id:String="breakpoint"):void{
			MonsterDebugger.breakpoint(caller, id);
			
		}
		
		/**
		 * Clears logging output
		 */
		public function clear():void{
			MonsterDebugger.clear(); 
		}
		
		/**
		 * Clears logging output
		 */
		public function set enabled(value:Boolean):void{
			MonsterDebugger.enabled = value;
		}

		public function get enabled():Boolean{
			
			return MonsterDebugger.enabled;
		}

		/**
		 *
		 * @param lock
		 * @throws Error
		 */
		public function LoggingManager(lock:Class)
		{

			if (lock != SingletonLock)
			{
				throw new Error("Invalid Singleton access.  Use Model.instance.");
			}
		}

		private var _isInitialized:Boolean;
 
		
		public function get isInitialized():Boolean
		{

			return _isInitialized;
		}

		 
		internal function validateManager():void
		{

			if (!_isInitialized)
				throw new Error("Loggin Manager: You must initialize the manager first");
		}
 
	}
}


class SingletonLock
{
}
