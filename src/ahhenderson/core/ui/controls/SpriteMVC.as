package ahhenderson.core.ui.controls
{ 
	import ahhenderson.core.mvc.interfaces.IFacadeView;
	
	import starling.display.Sprite;
	
	public class SpriteMVC extends Sprite implements IFacadeView
	{
		
		public function SpriteMVC()
		{
			 
			super();
		}
	  
		include "../../../../includes/ahhenderson/core/FacadeViewIncludes.inc"
		
		// Supporting global suspension
		include "../../../../includes/ahhenderson/core/SuspendModeIncludes.inc"
		
	}
}