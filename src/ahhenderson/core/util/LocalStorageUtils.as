//------------------------------------------------------------------------------
//
//   ViziFit, Inc.  Copyright 2012  
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.util {
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	/**
	 *
	 * @author tony.henderson
	 */
	public class LocalStorageUtils {


		public function LocalStorageUtils() {

		}

		private static var m_so:SharedObject;

		private static var m_soKey:String;

		private static var m_storageSize:int;

		/**
		 * Get value from local settings object
		 *
		 * @propertyName: Property for item to be retrieved
		 * @showAllProperties: Return array of all properties in the local settings object.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function getItem(propertyName:String, defaultValue:* = null, showAllProperties:Boolean = false):* {

			if (!m_so)
				initLocalStorage();

			// Show trace of properties.
			if (showAllProperties) {

				var properties:Array = new Array();

				for (var prop:String in m_so.data) {

					properties.push(prop);
						//trace(prop + ": " + m_so.data[prop]);
				}

				return properties;
			}

			// Return requested properties.
			if (m_so.data.hasOwnProperty(propertyName)) {
				return m_so.data[propertyName];
			} else if (defaultValue) {
				return defaultValue;
			}

			// Return null if nothing is retrieved and no default value is specified.
			return null;
		}

		/**
		 * Initialize the local shared object (not required)
		 *
		 * @key: Custom key for shared object
		 * @storageSize: Storage size in Kilobytes
		 *
		 * @default - 10MB
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function initLocalStorage(key:String = "defaultKey", storageSize:int = 10000):void {

			if (!key)
				return;

			m_soKey = key;
			m_storageSize = storageSize;
			m_so = SharedObject.getLocal(m_soKey);
		}

		public static function removeItem(propertyName:String):void {

			if (!m_so)
				initLocalStorage();

			if (m_so.data.hasOwnProperty(propertyName))
				delete m_so.data[propertyName];
		}

		/**
		 * Adds/updates item in local shared object
		 *
		 * @propertyName: Name of the property to add
		 * @propertyValue: Value of the property to add
		 *
		 *
		 * @langversion 3.0
		 * @playerversion Flash 11.5
		 * @playerversion AIR 3.5
		 * @productversion Starling 1.2, Flex 4.6 
		 */
		public static function upsertItem(propertyName:String, propertyValue:* = null):void {

			//LogHpr.log(LType.INFO, LCategory.LOCAL_CACHE, "Saving to Storage", "saving property [" + propertyName + "] and value [" + propertyValue + "]...")

			if (!m_so)
				initLocalStorage();

			m_so.data[propertyName] = propertyValue;

			var flushStatus:String = null;

			try {
				flushStatus = m_so.flush(m_storageSize);
			} catch (error:Error) {
				
				trace("LocalStorageUtil Error: " + error.message);
					
				//LogHpr.log(LType.ERROR, LCategory.LOCAL_CACHE, "Error Saving to Storage", "Error...Could not write property [" + propertyName + "] and value [" + propertyValue + "] to SharedObject...")

			}
			if (flushStatus != null) {
				switch (flushStatus) {
					case SharedObjectFlushStatus.PENDING:

						trace("LocalStorageUtil INO: Flush Pending");
						//LogHpr.log(LType.INFO, LCategory.LOCAL_CACHE, "Pending permission to save", "Requesting permission to save object with property [" + propertyName + "] and value [" + propertyValue + "]...");
						m_so.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
						break;

					case SharedObjectFlushStatus.FLUSHED:
						trace("LocalStorageUtil INO: Flushed Storage");
						//LogHpr.log(LType.INFO, LCategory.LOCAL_CACHE, "Value flushed to Disk", "Value flushed to disk with property [" + propertyName + "] and value [" + propertyValue + "]...");
						break;
				}
			}
			//output.appendText("\n");
		}


		private static function onFlushStatus(event:NetStatusEvent):void {
			//output.appendText("User closed permission dialog...\n");
			switch (event.info.code) {
				case "SharedObject.Flush.Success":
					trace("LocalStorageUtil INO: Flush success");
					//LogHpr.log(LType.INFO, LCategory.LOCAL_CACHE, "User granted permission", "Value saved to disk...");
					trace("User granted permission -- value saved.\n");
					break;
				case "SharedObject.Flush.Failed":
					
					trace("LocalStorageUtil INO: Flush failed");
					//LogHpr.log(LType.ERROR, LCategory.LOCAL_CACHE, "User denied permission", "Value NOT saved to disk...");
					break;
			}

			m_so.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
		}
	}
}
