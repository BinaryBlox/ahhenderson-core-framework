 
package ahhenderson.core.managers.dependency.objectPool {
	import ahhenderson.core.collections.interfaces.IEnumerableDictionaryItem;
	import ahhenderson.core.managers.dependency.objectPool.interfaces.IPool;
	import ahhenderson.core.managers.dependency.objectPool.interfaces.IPoolObject;
	import ahhenderson.core.managers.dependency.objectPool.interfaces.IPoolType;
	import ahhenderson.core.collections.interfaces.IEnumeration;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.utils.UIDUtil;

	/**
	 * Loan Shark - a flexible and high performance object pooling utility
	 * @author Liam O'Donnell
	 * @version 1.0
	 * @usage Constructor an instance with your given class and use getObject/putObject to check instances in and out of the pool
	 * @see http://www.spikything.com/blog/?s=objectpool for info/updates
	 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
	 * © 2011 spikything.com
	 */
	public class Pool implements IEnumerableDictionaryItem, IPool {

		/**
		 * The ID of the Error thrown in strict mode when attempting to check-in an object of the wrong type
		 */
		public static const ERROR_CHECK_IN_TYPE:int = 3;

		/**
		 * The ID of the Error thrown in strict mode when attempting to check-in an object instance already checked into the pool
		 */
		public static const ERROR_MULTI_CHECK_IN:int = 4;

		/**
		 * The ID of the Error thrown in strict mode when attempting to check-in a null object reference
		 */
		public static const ERROR_NULL_CHECK_IN:int = 2;

		/**
		 * The ID of the Error thrown in strict mode when attempting to recycle an object to a pool with no checked-out objects
		 */
		public static const ERROR_RECYCLE_UNUSED:int = 1;

		/**
		 * The type of Event dispatched when the pool is pruned of unused objects
		 */
		public static const EVENT_CLEANED:String = 'cleaned';

		/**
		 * The type of Event dispatched when the pool is prepared for destruction and rendered unusable
		 */
		public static const EVENT_DISPOSED:String = 'disposed';

		/**
		 * The type of Event dispatched when the pool is emptied and reinitialised
		 */
		public static const EVENT_FLUSHED:String = 'flushed';
		 


		/**
		 * Creates an object pool for maintaining and reusing instances of the given class
		 * @param ObjectClass Any class you wish to pool
		 * @param strictMode [optional] Specifies that the pool will throw errors, rather than just ignore, if invalid objects are checked back into the pool
		 * @param initialSize [optional] Initialises the pool with the given number of object instances
		 * @param maxBuffer [optional] Specifies a maximum amount of waste allowed in the pool before it is automatically pruned of unused objects
		 * @param initObject [optional] Specifies an object that will be passed to the constructor of pooled objects
		 * @param resetMethod [optional] A method name to invoke on pooled objects as they are recycled back to the pool
		 * @param disposeMethod [optional] A method name to invoke when disposing of pooled object instances
		 */
		public function Pool(key:IEnumeration,
			ObjectClass:Class, 
			strictMode:Boolean = false,
			initialSize:uint = 0,
			maxBuffer:uint = 0,
			initObject:Object = null,
			defaultResetFunction:Function = null,
			resetMethod:String = '',
			disposeMethod:String = '',
			isUpdateable:Boolean = true) {
			_dispatcher = new EventDispatcher();
			_ObjectClass = ObjectClass;
			_strictMode = strictMode;
			_keyAsEnum = key;
			_key = key.value;

			if (initialSize > _idealArrayInitialSize)
				_idealArrayInitialSize = initialSize;

			flush();
			_maxBuffer = maxBuffer;
			_initObject = initObject;
			_resetMethod = resetMethod;
			_disposeMethod = disposeMethod;
			_defaultResetObjectFunction = defaultResetFunction;
			_isUpdateable = isUpdateable;

			var i:uint = initialSize;
			
			while (i--)
				createAndAddObject();
		}


		private var _ObjectClass:Class;

		public function get defaultResetObjectFunction():Function
		{
			return _defaultResetObjectFunction;
		}

		public function set defaultResetObjectFunction(value:Function):void
		{
			_defaultResetObjectFunction = value;
		}

		/**
		 * Returns the class reference for the type of object pooled by this instance
		 */
		public function get ObjectClass():Class {
			return _ObjectClass;
		}

		private var _isUpdateable:Boolean;

		public function get isUpdateable():Boolean {
			return _isUpdateable;
		}

		private var _key:String;

		public function get key():String {
			return _key;
		}

		private var _keyAsEnum:IEnumeration;

		public function get keyAsEnum():IEnumeration {
			return _keyAsEnum;
		}

		public function get type():IPoolType{
			return IPoolType(_keyAsEnum);
		}
		
		private var _size:int;

		/**
		 * The total number of objects in the pool (used and unused)
		 */
		public function get size():int {
			return _size;
		}

		/**
		 * The pool buffer or wastage (number of currently unused objects)
		 */
		public function get unused():int {
			return _bufferSize;
		}

		/**
		 * The number of objects in the pool that are currently in-use
		 */
		public function get used():int {
			return _size - _bufferSize;
		}

		private var _bufferSize:int;

		private var _dispatcher:EventDispatcher;

		private var _disposeMethod:String;

		private var _idealArrayInitialSize:uint = 500;

		private var _initObject:Object;

		private var _maxBuffer:uint;

		private var _objectsInUse:Array;

		private var _pool:Array;

		private var _resetMethod:String;

		private var _strictMode:Boolean;
		
		private var _defaultResetObjectFunction:Function;
		

		/**
		 * Registers an event listener in the usual way
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * Gets an object from the pool, creating one only if necessary
		 * @return An object of the type specified by ObjectPool constructor's ObjectClass parameter
		 */
		public function borrowObject():* {
			var objectToBorrow:*;

			if (_bufferSize == 0)
				objectToBorrow = createObject();
			else
				objectToBorrow = _pool[--_bufferSize];

			if (_strictMode)
				_objectsInUse.push(objectToBorrow);

			// Add unique id for each used item in pool
			if(objectToBorrow && objectToBorrow is IPoolObject)
				IPoolObject(objectToBorrow).initObject(UIDUtil.createUID());
			
			return objectToBorrow;
		}

		/**
		 * Prunes the pool of unused objects to conserve memory
		 */
		public function optimize():void {
			var unused:uint = _bufferSize;

			if (unused > 0) {
				var cleanCount:uint = Math.min(_size, unused);
				disposeObjects();
				createList();

				_bufferSize = 0;
				_size -= cleanCount;
			}

			dispatch(EVENT_CLEANED);
		}

		/**
		 * Destroys everything and prepares the pool for garbage collection
		 */
		public function dispose():void {
			flush(true, true);

			_ObjectClass = null;
			_initObject = null;
			_pool = null;
			_objectsInUse = null;
			_resetMethod = null;
			_disposeMethod = null;

			dispatch(EVENT_DISPOSED);
			_dispatcher = null;
		}

		/**
		 * Empties the pool completely and reinitialises it
		 * @param force - Forces the flush, even if some objects are still in-use (otherwise the flush is skipped)
		 * @param disposeUnusedObjects - Also attempts to call the 'dispose' method of each pooled object (if any)
		 */
		public function flush(force:Boolean = false, disposeUnusedObjects:Boolean = false):void {
			if (used > 0 && !force)
				return;

			if (disposeUnusedObjects)
				disposeObjects();

			_size = _bufferSize = 0;
			createList();

			dispatch(EVENT_FLUSHED);
		}

		/**
		 * Unregisters an event listener in the usual way
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_dispatcher.removeEventListener(type, listener, useCapture);
		}

		/**
		 * Recycles an object back into the pool for later reuse
		 * @param object - An object of the ObjectClass type that originated from the pool
		 */
		public function returnObject(object:*):void {
			var isCorrectType:Boolean = object is _ObjectClass;

			var isAlreadyCheckedIn:Boolean = false;
			if (_strictMode) {
				var usageIndex:int = _objectsInUse.indexOf(object);
				if (usageIndex == -1)
					isAlreadyCheckedIn = true;
				else
					_objectsInUse.splice(usageIndex, 1);
			}

			if (object && isCorrectType && used > 0 && !isAlreadyCheckedIn) {
				
				addToPool(object, true);
			} else if (_strictMode) {
				if (!used)
					throw new Error('You cannot return an object to a pool with no checked-out items. The specified object did not appear to come from this pool.', ERROR_RECYCLE_UNUSED);

				if (object == null)
					throw new Error('You cannot return a null object reference to the pool.', ERROR_NULL_CHECK_IN);

				if (!isCorrectType)
					throw new Error('You cannot return an object of the wrong type ' + object + ' a pool of type ' + _ObjectClass + '.', ERROR_CHECK_IN_TYPE);

				if (isAlreadyCheckedIn)
					throw new Error('You cannot return an object to the pool when it\'s already checked-in.', ERROR_MULTI_CHECK_IN);
			}

			if (_maxBuffer && _bufferSize > _maxBuffer)
				optimize();
		}

		private function addToPool(object:*, reset:Boolean = false):void {
			
			if(object is IPoolObject){
				IPoolObject(object).poolType = this.type;
				IPoolObject(object).isPooled=true;
				IPoolObject(object).resetObject();
			}
			
			//trace("Pool item type: ", IPoolObj(object).poolType.value);
		/*	if (reset && _resetMethod != '')
				object[_resetMethod]();*/

			_pool[_bufferSize++] = object;
		}

		private function createAndAddObject():void {
			addToPool(createObject());
		}

		private function createList():void {
			_pool = new Array(_idealArrayInitialSize);
			_objectsInUse = new Array();
		}

		private function createObject():* {
			_size++;
			return _initObject == null ? new _ObjectClass() : new _ObjectClass( _initObject);
		}

		private function dispatch(eventType:String):void {
			_dispatcher.dispatchEvent(new Event(eventType));
		}

		private function disposeObjects():void {
			if (_disposeMethod == '')
				return;

			var obj:Object;
			for (var i:int = 0; i < _bufferSize; i++) {
				obj = _pool[i];
				if (obj)
					obj[_disposeMethod]();
			}
		}
	}

}
