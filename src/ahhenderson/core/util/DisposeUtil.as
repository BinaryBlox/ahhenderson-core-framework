package ahhenderson.core.util {
	import starling.display.DisplayObject;

	public class DisposeUtil {
		public function DisposeUtil() {
		}

		public static function disposeDisplayObjectVector(value:Vector.<DisplayObject>):void{
			var i:int = value.length;
			
			while(i--){
				
				value[i].dispose();
			}
			
		}
	}
}
