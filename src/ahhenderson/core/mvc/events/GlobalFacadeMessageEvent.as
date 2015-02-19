//------------------------------------------------------------------------------
//
//  
//  Copyright 2012 by Anthony Henderson   
//  All rights reserved.  
//  
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.events {
	import ahhenderson.core.mvc.enums.GlobalFacadeActionType;
	import ahhenderson.core.mvc.patterns.facade.FacadeMessage;
	
	import flash.events.Event;
	/**
	 *
	 * @author tony.henderson
	 */
	public class GlobalFacadeMessageEvent extends Event {
		/**
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public static const GLOBAL_MESSAGE_MANAGER_EVENT:String="globalMessageManagerEvent";

		public function GlobalFacadeMessageEvent(type:String,
			action:GlobalFacadeActionType,
			message:FacadeMessage,
			bubbles:Boolean=true) {

			super(type, bubbles);

			_action=action;
			_message=message;
		}

		private var _action:GlobalFacadeActionType;

		private var _message:FacadeMessage;

		public function get action():GlobalFacadeActionType {
			return _action;
		}

		public function get message():FacadeMessage {
			return _message;
		}
	}

}