//------------------------------------------------Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.mvc.patterns.facade {
	import ahhenderson.core.mvc.interfaces.IFacadeView;


	public class AbstractFacadeView implements IFacadeView {
 
		include "../../../../../includes/ahhenderson/core/FacadeViewIncludes.inc"

		// Supporting global suspension
		include "../../../../../includes/ahhenderson/core/SuspendModeIncludes.inc"


		public function AbstractFacadeView() {
			super();
		}
	}
}
