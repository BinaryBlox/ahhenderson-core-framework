//------------------------------------------------------------------------------
//
//   Anthony Henderson  
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.util {
	/**
	 *
	 * @author tony.henderson
	 */
	public final class KeyboardUtil {

		/**
		 *
		 * @default
		 */
		public static const COPY:int  = 4;

		/**
		 *
		 * @default
		 */
		public static const CUT:int   = 2;

		/**
		 *
		 * @default
		 */
		public static const PASTE:int = 3;

		/**
		 *
		 * @default
		 */
		public static const REDO:int  = 1;

		/**
		 *
		 * @default
		 */
		public static const UNDO:int  = 0;

		/**
		 *
		 * @param keyboardPressedCollection
		 * @return
		 */
		public static function checkKeyboardCombination(keyboardPressedCollection:Array):int {

			var retCombinationState:int = -1;
			var combinationLength:int;
			var confirmedKeys:int = 0;
			var combinationCollection:Vector.<Array> = KeyboardUtil.getCombinationCollection;

			combinationCollection.forEach(function callback(combination:Array, selectedState:int, combinationCollection:Vector.<Array>):void {

				confirmedKeys=0;

				combination.forEach(function callback(checkKey:int, index:int, array:Array):void {

					combinationLength=combination.length + 1;

					keyboardPressedCollection.forEach(function callback(keyPressed:int, idx:int, arr:Array):void {

						if (keyPressed == checkKey)
							confirmedKeys++;
					});

					if (confirmedKeys == combinationLength - 1)
						retCombinationState=selectedState;
				});
			});

			return retCombinationState;
		}


		/**
		 *
		 * @return
		 */
		public static function get getCombinationCollection():Vector.<Array> {

			var combinationCollection:Vector.<Array> = new Vector.<Array>();
			combinationCollection.push(new Array(17, 90));
			combinationCollection.push(new Array(17, 16, 90));
			combinationCollection.push(new Array(17, 88));
			combinationCollection.push(new Array(17, 86));
			combinationCollection.push(new Array(17, 67));

			return combinationCollection;
		}
	}

/**
 *
 * @Usage
 *
 * private var keyboardCollectionPressed:Array = new Array();
mainView.stage.addEventListener(KeyboardEvent.KEY_DOWN, function(event:KeyboardEvent):void {
	keyboardCollectionPressed.push( event.keyCode );
} );
mainView.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);

private function onKeyboardUp(event:KeyboardEvent):void
{
	var combination:int = KeyBoardCombination.checkKeyboardCombination( keyboardCollectionPressed );

	switch (combination)
	{
		case KeyBoardCombination.UNDO:
			trace("UNDO");
			break;
		case KeyBoardCombination.REDO:
			trace("REDO");
			break;
		case KeyBoardCombination.CUT:
			trace("CUT");
			break;
		case KeyBoardCombination.PASTE:
			trace("PASTE");
			break;
		case KeyBoardCombination.COPY:
			trace("COPY");
			break;
 */
 
}