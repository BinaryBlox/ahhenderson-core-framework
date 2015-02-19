//------------------------------------------------Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.patterns.facade {
	import flash.display.BitmapData;
	
	import ahhenderson.core.mvc.interfaces.IFacadeView;


	public class AbstractFacadeView implements IFacadeView {
 
		
		include "../../../_includes/_FacadeViewIncludes.inc"
		
		// Supporting global suspension
		include "../../../_includes/_SuspendModeIncludes.inc"

		public function AbstractFacadeView() {
			super();
		}
	}
}
