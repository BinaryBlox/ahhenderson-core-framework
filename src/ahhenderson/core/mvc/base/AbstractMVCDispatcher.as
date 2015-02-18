//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.base {
	import ahhenderson.core.mvc.interfaces.IFacadeView;
	
	import flash.events.EventDispatcher;


	public class AbstractMVCDispatcher extends EventDispatcher implements IFacadeView {
 
		 
		public function AbstractMVCDispatcher() {
			super();
		}
		
		include "../../../../includes/ahhenderson/core/FacadeViewIncludes.inc"
		
		// Supporting global suspension
		include "../../../../includes/ahhenderson/core/SuspendModeIncludes.inc"
	}
}