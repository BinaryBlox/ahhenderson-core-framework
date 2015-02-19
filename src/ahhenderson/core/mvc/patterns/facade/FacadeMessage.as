/*----------------------------------------------------------------------------*/
/*                                                                            */
/*   Copyright 2012 Anthony Henderson                                           */
/*   All rights reserved.                                                     */
/*                                                                            */
/*----------------------------------------------------------------------------*/

package ahhenderson.core.mvc.patterns.facade
{

	import ahhenderson.core.mvc.interfaces.IFacadeMessage;

	/**
	 *
	 * @author tony.henderson
	 */
	public class FacadeMessage implements IFacadeMessage
	{

		/**
		 * If no message filter is entered then the messageId will be used for the filter.
		 * 
		 * @param messageId
		 * @param messageBody
		 * @param messageFilter
		 * @param args
		 */
		public function FacadeMessage(messageId:String, messageBody:Object=null, messageFilter:FacadeMessageFilter=null, ... args)
		{
			this._messageId=messageId;
			this._messageFilter=messageFilter;
			this._messageBody=messageBody;
			this._args=args;
			
			// Set messageId as filter
			if(FacadeMessageFilter.isEmpty(this._messageFilter)) 
				this._messageFilter = new FacadeMessageFilter(null, [messageId]);
			 
		}

		private static var _convertedMessage:FacadeMessage;
		
		/**
		 * 
		 * @default 
		 */
		protected var _args:Array;

		/**
		 * 
		 * @default 
		 */
		protected var _messageBody:Object;
		
		/**
		 * 
		 * @default 
		 */
		protected var _messageBodyClass:String;

		protected var _messageFilter:FacadeMessageFilter;

		/**
		 * 
		 * @default 
		 */
		protected var _messageId:String;
		 
		/**
		 * 
		 * @default 
		 */
		public function set messageFilter(value:FacadeMessageFilter):void
		{
			_messageFilter = value;
		}

		 
		/**
		 * 
		 * @return 
		 */
		public function get messageBodyClass():String
		{
			return _messageBodyClass;
		}

		/**
		 * 
		 * @param value
		 */
		public function set messageBodyClass(value:String):void
		{
			_messageBodyClass = value;
		}

		/**
		 * 
		 * @return 
		 */
		public function get args():Array
		{
			return _args;
		}

		/**
		 * 
		 * @return 
		 */
		public function get messageBody():Object
		{
			return _messageBody;
		}

		/**
		 * 
		 * @return 
		 */
		public function get messageFilter():FacadeMessageFilter
		{
			return _messageFilter;
		}

		/**
		 * 
		 * @return 
		 */
		public function get messageId():String
		{
			return _messageId;
		}
		
		// Use when passing in rest parameters argument.
		/**
		 * 
		 * @param args
		 */
		public function setArgs(...args):void{
			_args = args;
		}
		
		/**
		 * 
		 * @param obj
		 * @return 
		 */
		/*public static function getGlobalMessageSO(obj:Object):GlobalMessageSO {
			
			if(!obj["messageId"])
				return null;
			
			_convertedMessage = new GlobalMessageSO(obj["messageId"], obj["messageBody"], obj["messageFilter"]);
			
			// Handle arguments
			_convertedMessage.setArgs.apply(null, obj["args"]); 
			  
			return _convertedMessage;  
		}*/

	}
}

