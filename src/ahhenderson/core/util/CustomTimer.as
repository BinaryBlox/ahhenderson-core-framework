package ahhenderson.core.util
{       
   
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class CustomTimer extends Timer
    {
        private var _timerData:Object;
		private var _timerAction:uint;
		private static var _timer:Timer;
		
        public function CustomTimer(delay:Number, repeatCount:int=0)
        {
            super(delay, repeatCount);
            _timerData = new Object();
        }

        public function get TimerData():Object
        {
            return _timerData;
        }

        public function set TimerData(value:Object):void
        {
            _timerData = value;
        }
        
        public function get TimerAction():uint
        {
            return _timerAction;
        }

        public function set TimerAction(value:uint):void
        {
            _timerAction = value;
        }
		
		public static function delayAction(duration:int):void{
			 
			_timer = new Timer(duration, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete, false, 0, true);
			_timer.addEventListener(TimerEvent.TIMER, onTimerTick, false, 0, true);
			_timer.start();
		}
		
		public static function onTimerTick(e:TimerEvent):void{
			trace("tick");
		}
		
		private static function onTimerComplete(e:TimerEvent):void{
			_timer.removeEventListener(TimerEvent.TIMER, onTimerTick);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
    }
}