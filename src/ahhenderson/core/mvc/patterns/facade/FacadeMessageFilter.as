/*----------------------------------------------------------------------------*/
/*                                                                            */
/*   Copyright 2012 ViziFit, Inc.                                          */
/*   All rights reserved.                                                     */
/*                                                                            */
/*----------------------------------------------------------------------------*/

package ahhenderson.core.mvc.patterns.facade {


	/**
	 * 
	 * @author thenderson
	 */
	public class FacadeMessageFilter {
		/**
		 * 
		 * @param messageGroups
		 * @param messageTypes
		 * @param strictFilter
		 */
		public function FacadeMessageFilter(messageGroups:Array = null, messageTypes:Array = null, strictFilter:Boolean = true) {
			this._messageGroups = messageGroups;
			this._messageTypes = messageTypes;
			this._strictFilter = strictFilter;
		}

		/**
		 * 
		 * @param messageFilter
		 * @return 
		 */
		public static function isEmpty(messageFilter:FacadeMessageFilter):Boolean {

			var bMessageGroups:Boolean;
			var bMessageTypes:Boolean;

			if (!messageFilter)
				return true;

			if (messageFilter.messageGroups && messageFilter.messageGroups.length > 0)
				bMessageGroups = true;

			if (messageFilter.messageTypes && messageFilter.messageTypes.length > 0)
				bMessageTypes = true;

			return (bMessageGroups || bMessageTypes) ? false : true;
		}

		/**
		 * 
		 * @default 
		 */
		public static var DEFAULT_FILTER_GROUP:String = "defaultMessageFilterGroup";

		/**
		 * Returns a message filter with the default filter group. 
		 * Great option if you're not sure what you want to filter.
		 * 
		 * @return 
		 */
		public static function defaultFilterFactory():FacadeMessageFilter{
			
			return new FacadeMessageFilter([DEFAULT_FILTER_GROUP]);
		}
		
		private var _messageGroups:Array;

		private var _messageTypes:Array;

		private var _strictFilter:Boolean;

		/**
		 * 
		 * @return 
		 */
		public function get messageGroups():Array {
			return _messageGroups;
		}

		/**
		 * 
		 * @param value
		 */
		public function set messageGroups(value:Array):void {
			_messageGroups = value;
		}

		/**
		 * 
		 * @return 
		 */
		public function get messageTypes():Array {
			return _messageTypes;
		}

		/**
		 * 
		 * @param value
		 */
		public function set messageTypes(value:Array):void {
			_messageTypes = value;
		}

		/**
		 * 
		 * @return 
		 */
		public function get strictFilter():Boolean {
			return _strictFilter;
		}
	}
}

