//------------------------------------------------------------------------------
//
//  
//  Copyright 2012 by ViziFit, Inc.  
//  All rights reserved.  
//  
//
//------------------------------------------------------------------------------

package ahhenderson.core.managers.dependency.facadeService.events {
	import flash.events.Event;
	 
	
	
	/**
	 *
	 * @author tony.henderson
	 */
	public class FacadeServiceManagerEvent extends Event {
		/**
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public static const SHOW_DIALOG:String="FSM_ShowDialog";
		
		public static const HIDE_DIALOG:String="FSM_HideDialog";

		private var _data:Object;
		
		public function FacadeServiceManagerEvent(type:String, 
			data:Object=null,
			bubbles:Boolean=false, cancelable:Boolean=false) {

			_data = data;
			
			super(type, bubbles, cancelable);
 
		}
 
		public function get data():Object
		{
			return _data;
		}

	}

}