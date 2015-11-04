//------------------------------------------------------------------------------
//
//  
//  Copyright 2012 by Anthony Henderson   
//  All rights reserved.  
//  
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.events {
	import flash.events.Event;
	
	import ahhenderson.core.mvc.enums.ActorType;
	import ahhenderson.core.mvc.interfaces.IModelActor;

	/**
	 *
	 * @author tony.henderson
	 */
	public class GlobalFacadeModelEvent extends Event {
		/**
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public static const GLOBAL_FACADE_MODEL_EVENT:String="GLOBAL_FACADE_MODEL_EVENT";
		 
		
		public static const MODEL__ADD_ACTION:String="MODEL__ADD_ACTION";
		
		public static const MODEL__DELETE_ACTION:String="MODEL__DELETE_ACTION";
		
		public static const MODEL__UPDATE_ACTION:String="MODEL__UPDATE_ACTION";

		public function GlobalFacadeModelEvent(type:String,
			model:IModelActor,
			action:String,
			bubbles:Boolean=true) {

			super(type, bubbles);

			_model = model;
			_action=action; 
		}
		
		private var _model:IModelActor;

		private var _action:String;
 

		public function get model():IModelActor
		{
			return _model;
		}

		public function get action():String {
			return _action;
		}
 
	}

}