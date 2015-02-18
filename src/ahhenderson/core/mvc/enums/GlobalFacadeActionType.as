//------------------------------------------------------------------------------
//
//  
//  Copyright 2012 by ViziFit, Inc.  
//  All rights reserved.  
//  
//
//------------------------------------------------------------------------------
 
package ahhenderson.core.mvc.enums {

	
	public final class GlobalFacadeActionType {

		public static const ROUTE_GLOBAL_MESSAGE:GlobalFacadeActionType=new GlobalFacadeActionType("routeGlobalMessageEnum");

		private static var locked:Boolean=false;
		
		{
			locked=true;
		}

		public function GlobalFacadeActionType(GlobalMessageActionEnum:String):void {
			if (locked) {
				throw new Error("You can't instantiate GlobalMessageActionEnum");
			}
			_globalMessageActionEnum=GlobalMessageActionEnum;
		}

		private var _globalMessageActionEnum:String;

		public function get globalMessageActionEnum():String {
			return _globalMessageActionEnum;
		}
	}
}
