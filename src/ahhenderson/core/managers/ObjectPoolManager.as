//------------------------------------------------------------------------------
//
//   Anthony Henderson Copyright 2011 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.managers {
	import ahhenderson.core.collections.EnumerableDictionaryList;
	import ahhenderson.core.managers.dependency.objectPool.Pool;
	import ahhenderson.core.managers.dependency.objectPool.enums.PoolInfoType;
	import ahhenderson.core.managers.dependency.objectPool.interfaces.IPoolObject;
	import ahhenderson.core.managers.dependency.objectPool.interfaces.IPoolType;

	public class ObjectPoolManager {

		public static const DEFAULT_DISPOSE_METHOD:String = "dispose";

		public static const DEFAULT_POOL_BUFFER:int = 100;

		// =======================================
		//  Singleton instance
		// =======================================

		public static const DEFAULT_POOL_SIZE:int = 50;

		public static const DEFAULT_RESET_METHOD:String = "resetObject";


		private static const _instance:ObjectPoolManager = new ObjectPoolManager(SingletonLock);

		private var defaultPoolsCreated:Boolean;

		private var _debug:Boolean=false;
		
		private var _logger:LoggingManager;
		
		private function get logger():LoggingManager
		{
			if(!_logger)
				_logger = LoggingManager.instance;
			
			return _logger;
		}

		public function get debug():Boolean
		{
			return _debug;
		}

		public function set debug(value:Boolean):void
		{
			_debug = value;
		}

		public static function get instance():ObjectPoolManager {
 
			return _instance;
		}


		/**
		 * Constructor
		 *
		 * @param lock The Singleton lock class to pevent outside instantiation.
		 */
		public function ObjectPoolManager(lock:Class) {
			// Verify that the lock is the correct class reference.
			if (lock != SingletonLock) {
				throw new Error("Invalid Singleton access.  Use Model.instance.");
			} 
	
			// TODO: Deprecate?
			// Create initial pools of commonly used objects
			//createDefaultPools();
		}


		//------------------------------------------------------------------------------
		//   Properties 
		//------------------------------------------------------------------------------

		private var _autoCreatePool:Boolean;

		public function get autoCreatePool():Boolean {
			return _autoCreatePool;
		}

		public function set autoCreatePool(value:Boolean):void {
			_autoCreatePool = value;
		}

		private var _defPoolSize:int = 50;

		public function get defPoolSize():int {
			return _defPoolSize;
		}

		public function set defPoolSize(value:int):void {
			_defPoolSize = value;
		}

		private var _useLastObject:Boolean;

		public function get useLastObject():Boolean {
			return _useLastObject;
		}

		public function set useLastObject(value:Boolean):void {
			_useLastObject = value;
		}

		private const CLASS_NAME:String = "PoolMgr";

		private var _enumerableDictionary:EnumerableDictionaryList

		private function get enumerableDictionary():EnumerableDictionaryList {
			if (!_enumerableDictionary)
				_enumerableDictionary = new EnumerableDictionaryList();

			return _enumerableDictionary;
		}

		private var m_count:uint;

		private var m_pool:Pool;

		 
		public function borrowObj(type:IPoolType = null):* {

			if (!validate(type))
				return null;
 
			if(_debug){
				logger.trace(type, "Creating: " + type.value);
				logger.trace(type, "Used: " + Pool(enumerableDictionary.getItem(type)).used.toString()); 
			}
		


			return Pool(enumerableDictionary.getItem(type)).borrowObject();
		}


		//------------------------------------------------------------------------------
		//   functions 
		//------------------------------------------------------------------------------

		public function createPool(type:IPoolType,
			defaultStyleName:String = null,
			size:int = DEFAULT_POOL_SIZE,
			buffer:int = DEFAULT_POOL_BUFFER,
			initObject:Object = null,
			disposeMethod:String = DEFAULT_DISPOSE_METHOD,
			resetMethod:String = DEFAULT_RESET_METHOD):void {

			m_pool = new Pool(type, type.objClass, false, size, buffer, initObject, defaultStyleName, resetMethod, disposeMethod);

			enumerableDictionary.addItem(m_pool);
		}


		public function deletePool(type:IPoolType):void {

			if (!validate(type))
				return;

			// Perform GC now
			Pool(enumerableDictionary.getItem(type)).dispose();

			// Remove item from collection
			enumerableDictionary.removeItem(type);
		}

		public function deletePools():void {
			enumerableDictionary.purgeItems();
		}

		public function getPoolInfo(type:IPoolType, info:PoolInfoType = null):int {
			if (!validate(type))
				return NaN;

			switch (info) {
				case PoolInfoType.POOL_SIZE:
					return Pool(enumerableDictionary.getItem(type)).size;

				case PoolInfoType.POOL_USED_OBJECTS:
					return Pool(enumerableDictionary.getItem(type)).used;

				case PoolInfoType.POOL_UNUSED_OBJECTS:
					return Pool(enumerableDictionary.getItem(type)).unused;
			}

			return NaN;
		}

		public function getPoolsInfo(info:PoolInfoType):int {

			var i:int = _enumerableDictionary.items.length;

			var size:int;

			while (i-- > -1) {


				switch (info) {
					case PoolInfoType.POOL_SIZE:
						size = size + Pool(_enumerableDictionary.items.getItemAt(i)).size;
						break;
					case PoolInfoType.POOL_USED_OBJECTS:
						size = size + Pool(_enumerableDictionary.items.getItemAt(i)).used;
						break;

					case PoolInfoType.POOL_UNUSED_OBJECTS:
						size = size + Pool(_enumerableDictionary.items.getItemAt(i)).unused;
						break;
				}

			}
			return size;
		}

		public function optimizePool(type:IPoolType):void {

			if (!validate(type))
				return;

			Pool(enumerableDictionary.getItem(type)).optimize();
		}

		public function optimizePools():void {
		/*
		m_count = enumerableDictionary.items.length;
		while (m_count--){
			enumerableDictionary.items.getItemAt(m_count)
		}*/
		}

		public function resetPool(type:IPoolType, force:Boolean = false, dispose:Boolean = false):void {
			if (!validate(type))
				return;

			Pool(enumerableDictionary.getItem(type)).flush(force, dispose);
		}

		public function resetPools():void {

		}

		public function returnObj(poolObj:*):* {

			if (!poolObj || !(poolObj is IPoolObject)){
				trace("Not a pool object ");
				return;
			}

			if (!validate(IPoolObject(poolObj).poolType))
				return null;

			Pool(enumerableDictionary.getItem(IPoolObject(poolObj).poolType)).returnObject(poolObj);

			if(_debug){
				trace("Returning: " + IPoolObject(poolObj).poolType.value);
				trace("User: " + Pool(enumerableDictionary.getItem(IPoolObject(poolObj).poolType)).used.toString());
				logger.trace(IPoolObject(poolObj).poolType, "Returning: " + IPoolObject(poolObj).poolType.value);
				logger.trace(IPoolObject(poolObj).poolType, "Used: " + Pool(enumerableDictionary.getItem(IPoolObject(poolObj).poolType)).used.toString());	 
			}
			

		}

		private function validate(type:IPoolType):Boolean {

			if (!enumerableDictionary.itemExists(type)) {
				throw new Error("Uncaught Error: Pool does not exist for :" + type.value);

				return false;
			}

			return true;
		}
		
		
		private function createDefaultPools():void{
			 
			// TODO - handle pool size by device type
			//createPool(BaseComponentPoolType.TITLED_TEXT_BLOCK, null, 10);
			//createPool(BaseComponentPoolType.ICON_LABEL, null, 15);
			//createPool(BaseComponentPoolType.VZ_BUTTON, null, 15);
			/*createPool(BasePoolObjType.TEXT_BLOCK_ENTRY, null, 100);*/
		/*	createPool(BasePoolObjType.TEXT_FIELD, null, 50);
			createPool(BasePoolObjType.BUTTON, null, 50);
			createPool(BasePoolObjType.TEXT_PANEL, null, 50);*/
		}
	}
}

class SingletonLock {
}

