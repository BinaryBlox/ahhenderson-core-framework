package ahhenderson.core.mvc.helpers
{
	import ahhenderson.core.mvc.patterns.facade.FacadeMessageFilter;

	public class GlobalFacadeHelper
	{
		public function GlobalFacadeHelper()
		{
		}
		
		public static function facadeMessageFilterFactory(messageGroups:Array=null, messageTypes:Array=null):FacadeMessageFilter{
			
			if(!messageGroups && !messageTypes)
				return null;
			
			return new FacadeMessageFilter(messageGroups, messageTypes);
			
		}
		
		 
	}
}