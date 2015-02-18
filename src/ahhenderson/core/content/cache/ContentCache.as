//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.content.cache {
	import ahhenderson.core.collections.DictionaryBuilder;
	import ahhenderson.core.collections.interfaces.IDictionaryItem;

	/***********************************************************************************************\
	 * ContentQueue Class - Designed to give generic functionality to a queue collection type.         *
	 * This collection is to be implemented in a FIFO principles. With adding, removing, searching,  *
	 * trace output, and state functions of the collection.                                          *
	 * @author : Richard Vacheresse /|\ http://www.rvacheresse.com /|\                               *
	 * Licensed for free Commercial and Private use creative commons license agreement.              *
	 * The provided code is in an "as-is" state. Richard Vacheresse makes no warranties              *
	 * regarding the provided code, and disclaims liability for damages resulting from its use.      *
	 * @version 1.0                                                                                  *
	 \***********************************************************************************************/
	public class ContentCache {


		/**
		 * ContentQueue() Constructor - Creates an empty queue using the default capacity.
		 * @variable - DEFAULT_CAPACITY - The default value for the queue's capacity.
		 * @variable - rear - Indicates the value of the last object + one as an Integer object.
		 * @variable - queue - The container object that will hold the objects of type array.
		 **/
		public function ContentCache(defaultCapacity:int = DEFAULT_CAPACITY):void {

			_defaultCapacity = defaultCapacity;

			//- set rear to 0 since the queue is empty 
			m_rear = 0;

			// - instantiate a new array object at the default capacity of 100
			_queue = new Vector.<IDictionaryItem>(defaultCapacity); //Array(defaultCapacity);

			//- output to console
			//LogHpr.log(LType.INFO, LCategory.MEDIA_CACHE, "New ContentQueue Created At Default Capacity.");

		}

		//- default capapcity of queue
		public static const DEFAULT_CAPACITY:int = 100;

		public static const PURGE_GROUP_SIZE:int = 100;


		private var _defaultCapacity:int;

		//- array object to hold the objects
		private var _queue:Vector.<IDictionaryItem>;

		//- indicates the value of the last
		private var m_rear:int;

		/**
		 * ContentQueueDefined(queueSize:int) function - Creates an empty queue using the passed in value.
		 **/
		public function ContentQueueDefined(queueSize:int):void {
			//- set rear to 0 since the queue is empty 
			m_rear = 0;

			// - instantiate a new array object at the passed value size
			_queue = new Vector.<IDictionaryItem>(queueSize);

			//- output to console
			//LogHpr.log(LType.INFO, LCategory.MEDIA_CACHE, "New ContentQueue Created At: " + queueSize);

		}

		public function get defaultCapacity():int {
			return _defaultCapacity;
		}

		public function set defaultCapacity(value:int):void {
			_defaultCapacity = value;
		}

		/**
		 * dequeue() function - Removes the first item in the queue.
		 *                    - Then shifts the queue minus the removed object
		 *                    - Decrement rear to reflect minus one object.
		 * @return - IDictionaryItem
		 **/
		public function dequeue():IDictionaryItem {
			//- if the collection is empty throw an error
			if (isEmpty())
				return null;

			//throw new Error("Queue contains no objects");

			//- else remove the object at the first position
			var result:IDictionaryItem = _queue[0];

			//- decrement the rear by one
			m_rear--;

			//- shift the elements forward one position
			for (var scan:int = 0; scan < m_rear; scan++)
				_queue[scan] = _queue[scan + 1];

			//- set the rear null again to null
			_queue[m_rear] = null;

			//- output to console
			//LogHpr.log(LType.INFO, LCategory.MEDIA_CACHE, "Item " + result.key + " dequeued.");
			 
			//- return the first objec in the array
			return result;
		}

		/**
		 * enqueue(obj:IDictionaryItem) function - Takes the passed object and adds it to the
		 *                                rear indicated position.
		 *                              - Increment the rear value + one to reflect
		 *                                the additional object.
		 **/
		public function enqueue(obj:IDictionaryItem):void {
			
			//LogHpr.log(LType.INFO, LCategory.MEDIA_CACHE, "Item " + obj.key + " enqueued.");
			 
			_queue[m_rear] = obj;
			m_rear++;
		}

		/**
		 * expandCapacity() function - Creates a new array of twice the size of the current
		 *                             array queue.
		 *                           - Then it repopulates the new larger Array with the
		 *                             original values.
		 **/
		public function expandCapacity():void {
			var result:int = (_queue.length * 2);
			var larger:Vector.<IDictionaryItem> = new Vector.<IDictionaryItem>(result);

			for (var scan:int = 0; scan < _queue.length; scan++)
				larger[scan] = _queue[scan];

			_queue = larger;
		}

		/**
		 * first() function - Returns the first object in the queue but does not remove it.
		 * @return - IDictionaryItem
		 **/
		public function first():IDictionaryItem {
			var result:IDictionaryItem = null;

			if (isEmpty()){
				//LogHpr.log(LType.INFO, LCategory.MEDIA_CACHE, "ContentQueue is empty");
			}
			
			//- set result pointer equal to first item but do not remove
			result = _queue[0];

			//- output to console
			//LogHpr.log(LType.INFO, LCategory.MEDIA_CACHE, "Item " + _queue[0] + " is next.");

			return result;
		}

		/**
		 * getLength() accessor function - Returns an integer value of the length of the queue.
		 * @return - Integer IDictionaryItem
		 **/
		public function getLength():int {
			return _queue.length;
		}


		public function getQueueItem(key:String):IDictionaryItem {

			return DictionaryBuilder.getItem(key, _queue);
		}

		/**
		 * isEmpty() function - Returns True if the value of rear is equal to zero.
		 * @return - Boolean IDictionaryItem
		 **/
		public function isEmpty():Boolean {
			return (m_rear == 0);
		}

		public function get queue():Vector.<IDictionaryItem> {
			return _queue;
		}


		public function itemExists(key:String):Boolean {

			var existingIndex:int = DictionaryBuilder.searchDictionary(key, _queue);


			if (existingIndex >= 0)
				return true

			return false;
		}

		/**
		 * size() function - Returns the number of objects in the queue.
		 * @return - Integer IDictionaryItem
		 **/
		public function size():int {
			return m_rear;
		}

		/**
		 * toString():String function - Returns a custom String object to represent the queue.
		 *                            - Overriden only because it is of type Sprite, (which has
		 *                              by default its' own toString() function), therefore we
		 *                              need more information about the queue.
		 * @return - String IDictionaryItem
		 **/
		public function toString():String {
			var result:String = ("------------------\n" + "Queue toString()\n" + "------------------\n" + "Queue has " + size() + " items.\n");

			for (var scan:int = 0; scan < m_rear; scan++) {
				result += ("Item: " + scan + " is a: " + _queue[scan] + "\n");
			}
			return result;
		}
	}
}
