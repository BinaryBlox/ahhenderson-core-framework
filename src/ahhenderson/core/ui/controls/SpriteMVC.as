package ahhenderson.core.ui.controls
{
	//import com.vizifit.core.managers.dependency.appMgr.interfaces.IAppDpi;
	
	import ahhenderson.core.mvc.interfaces.IFacadeView;
	
	import starling.display.Sprite;
	
	public class SpriteMVC extends Sprite implements IFacadeView
	{
		
		public function SpriteMVC()
		{
			 
			super();
		}
	/*	protected var _originalDPI:int;
		
		public function VzSprite(originalDPI:int=0)
		{
			// Set theme dpi
			//_originalDPI = originalDPI;
			
			super();
		}
		
		
		public function get originalDPI():int
		{
			// TODO Auto Generated method stub
			return _originalDPI;
		}*/
		
		
		include "../../../../includes/ahhenderson/core/FacadeViewIncludes.inc"
		
		// Supporting global suspension
		include "../../../../includes/ahhenderson/core/SuspendModeIncludes.inc"
		
	}
}