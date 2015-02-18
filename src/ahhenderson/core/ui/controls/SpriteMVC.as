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
	  
		
		include "../../includes/_FacadeViewIncludes.inc"
		
		// Supporting global suspension
		include "../../includes/_SuspendModeIncludes.inc"
		
	}
}