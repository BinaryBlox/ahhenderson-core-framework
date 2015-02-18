package ahhenderson.core.queue
{
 
	
	
	
	/***********************************************************************************************\
	 * FIFOQueue Class - Designed to give generic functionality to a queue collection type.         *
	 * This collection is to be implemented in a FIFO principles. With adding, removing, searching,  *
	 * trace output, and state functions of the collection.                                          *
	 * @author : Richard Vacheresse /|\ http://www.rvacheresse.com /|\                               *
	 * Licensed for free Commercial and Private use creative commons license agreement.              *
	 * The provided code is in an "as-is" state. Richard Vacheresse makes no warranties              *
	 * regarding the provided code, and disclaims liability for damages resulting from its use.      *
	 * @version 1.0                                                                                  *
	 \***********************************************************************************************/
	public class FIFOQueue 
	{
		//- default capapcity of queue
		public static const DEFAULT_CAPACITY:int = 100;
		//- indicates the value of the last
		private var m_rear:int;
		//- array object to hold the objects
		private var m_queue:Array;
		
		private var _defaultCapacity:int;
		
		public static const PURGE_GROUP_SIZE:int = 100;
		
		/**
		 * FIFOQueue() Constructor - Creates an empty queue using the default capacity.
		 * @variable - DEFAULT_CAPACITY - The default value for the queue's capacity.
		 * @variable - rear - Indicates the value of the last object + one as an Integer object.
		 * @variable - queue - The container object that will hold the objects of type array.
		 **/
		public function FIFOQueue(defaultCapacity:int = DEFAULT_CAPACITY):void
		{
			
			_defaultCapacity = defaultCapacity;
			
			//- set rear to 0 since the queue is empty 
			m_rear = 0;
			
			// - instantiate a new array object at the default capacity of 100
			m_queue = new Array(defaultCapacity);
			
			//- output to console
			//LogMgr.instance.log(LType.INFO, null, "New FIFOQueue Created At Default Capacity.");
			 
		}
		
		public function get defaultCapacity():int
		{
			return _defaultCapacity;
		}

		public function set defaultCapacity(value:int):void
		{
			_defaultCapacity = value;
		}

		/**
		 * FIFOQueueDefined(queueSize:int) function - Creates an empty queue using the passed in value. 
		 **/
		public function FIFOQueueDefined(queueSize:int):void
		{
			//- set rear to 0 since the queue is empty 
			m_rear = 0;
			
			// - instantiate a new array object at the passed value size
			m_queue = new Array(queueSize);
			
			//- output to console
			//LogMgr.instance.log(LType.INFO, null, "New FIFOQueue Created At: " + queueSize);
			 
		}
		
		/**
		 * dequeue() function - Removes the first item in the queue.
		 *                    - Then shifts the queue minus the removed object
		 *                    - Decrement rear to reflect minus one object.
		 * @return - Object
		 **/
		public function dequeue():Object
		{
			//- if the collection is empty throw an error
			if(isEmpty())
				return null;
				
			//throw new Error("Queue contains no objects");
			
			//- else remove the object at the first position
			var result:Object = m_queue[0];
			
			//- decrement the rear by one
			m_rear--;
			
			//- shift the elements forward one position
			for(var scan:int = 0; scan < m_rear; scan++)
				m_queue[scan] = m_queue[scan+1];
			
			//- set the rear null again to null
			m_queue[m_rear] = null;
			
			//- output to console
			//trace("Item " + result + " dequeued.");
			
			//- return the first objec in the array
			return result;
		}
		
		/**
		 * enqueue(obj:Object) function - Takes the passed object and adds it to the
		 *                                rear indicated position.
		 *                              - Increment the rear value + one to reflect
		 *                                the additional object.
		 **/
		public function enqueue(obj:Object):void
		{
			m_queue[m_rear] = obj;
			m_rear++;
		}
		
		/**
		 * first() function - Returns the first object in the queue but does not remove it.
		 * @return - Object
		 **/
		public function first():Object
		{
			var result:Object = "null";
			
			if(isEmpty())
				throw new Error("The queue is empty");
			//- set result pointer equal to first item but do not remove
			result = m_queue[0];
			//- output to console
			//LogMgr.instance.log(LType.INFO, null, "Item " + m_queue[0] + " is next.");
			 
			return result;
		}
		
		/**
		 * size() function - Returns the number of objects in the queue.
		 * @return - Integer Object 
		 **/
		public function size():int
		{
			return m_rear;
		}
		
		/**
		 * getLength() accessor function - Returns an integer value of the length of the queue.
		 * @return - Integer Object
		 **/
		public function getLength():int
		{
			return m_queue.length;
		}
		
		/**
		 * isEmpty() function - Returns True if the value of rear is equal to zero.
		 * @return - Boolean Object
		 **/
		public function isEmpty():Boolean
		{
			return (m_rear == 0);
		}
		
		/**
		 * expandCapacity() function - Creates a new array of twice the size of the current
		 *                             array queue.
		 *                           - Then it repopulates the new larger Array with the
		 *                             original values.
		 **/
		public function expandCapacity():void
		{
			var result:int = (m_queue.length*2);
			var larger:Array = new Array(result);
			
			for(var scan:int = 0; scan < m_queue.length; scan++)
				larger[scan] = m_queue[scan];
			
			m_queue = larger;
		}
		
		/**
		 * toString():String function - Returns a custom String object to represent the queue.
		 *                            - Overriden only because it is of type Sprite, (which has
		 *                              by default its' own toString() function), therefore we
		 *                              need more information about the queue.
		 * @return - String Object
		 **/
		public function toString():String
		{
			var result:String = ("------------------\n" +
				"Queue toString()\n" +
				"------------------\n" +
				"Queue has " + size() + " items.\n");
			
			for(var scan:int = 0; scan < m_rear; scan++)
			{
				result += ("Item: " + scan + " is a: " + m_queue[scan] + "\n");
			}
			return result;
		}
		
	}
}