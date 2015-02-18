package ahhenderson.core.queue.message
{
	import ahhenderson.core.queue.MessageQueue;
	
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	
	public class MessageQueueItemSO implements IDictionaryItem
	{
		
		private var _key:String;
		
		private var _timeout:int;
		
		private var _retryInterval:int;
		
		private var _isUpdateable:Boolean;
		
		private var _message:*;
		
		private var _timeStamp:Date;
		
		private var _sender:String;
		
		private var _lastRetry:Date;
		
		private var _args:Array;
		
		public var status:String = MessageQueue.MSG_STATUS_PENDING;
		
		
		public function MessageQueueItemSO(key:String, sender:String=null, message:*=null, timeout:int=0, retryInterval:int=100, isUpdateable:Boolean=true,...args)
		{
			_key = key;
			_sender = sender;
			_timeout = timeout;
			_retryInterval = retryInterval;
			_isUpdateable = isUpdateable;
			_message = message; 
			 
		}
		
		public function get retryInterval():int
		{
			return _retryInterval;
		}

		public function get lastRetry():Date
		{
			return _lastRetry;
		}

		public function set lastRetry(value:Date):void
		{
			_lastRetry = value;
		}

		public function get sender():String
		{
			return _sender;
		}

		public function set timeStamp(value:Date):void
		{
			_timeStamp = value;
		}

		public function get timeStamp():Date
		{
			return _timeStamp;
		}

		public function get message():*
		{
			return _message;
		}

		public function get timeout():int
		{
			return _timeout;
		}

		public function get isUpdateable():Boolean
		{
			return _isUpdateable;
		}
		
		public function get key():String
		{
			return _key;
		}
		
		public function get args():Array {
			
			return _args;
		}
		
		
		// Use when passing in rest parameters argument (with apply)
		public function setArgs(... args):void {
			
			_args=args;
		}
		
	}
}