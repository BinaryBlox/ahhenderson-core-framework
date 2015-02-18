//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.queue.message {
	import ahhenderson.core.collections.interfaces.IDictionaryItem;
	
	import org.osflash.signals.ISignal;
	
	public interface IMessageQueue extends IDictionaryItem {

		function get defaultTimeout():int;

		function hasMessage(key:String):Boolean;

		function get onMessageReLoop():ISignal;
		
		function get onMessageRetry():ISignal;

		function get onMessageRetryFailed():ISignal;

		function get pollingInterval():int;

		function initialize(queueItem:MessageQueueItemSO):void;
		
		function dispose():void;
		
		function popMessage(key:String):void;

		function pushMessage(queueItem:MessageQueueItemSO):void;
	}
}
