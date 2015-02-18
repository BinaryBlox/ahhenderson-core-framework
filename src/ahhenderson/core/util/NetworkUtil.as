//------------------------------------------------------------------------------
//
//   ViziFit, Inc. Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.util {
	import flash.net.InterfaceAddress;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;


	public class NetworkUtil {
		public function NetworkUtil() {
		}

		public static function getDefaultIp(isAir:Boolean = true):String {

			// TODO: Add logic to determine browser or desktop
			var netInterfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
			var addresses:Vector.<InterfaceAddress> = netInterfaces[1].addresses;
			return addresses[0].address;

		}
		
		 
		/*
		public static function printIpAddresses():void{
			
			var netInterfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
			if (netInterfaces && netInterfaces.length > 0) {    
				for each (var i:NetworkInterface in netInterfaces) {
					if (i.active) {
						var addresses:Vector.<InterfaceAddress> =i.addresses;
						for each (var j:InterfaceAddress in addresses) {
							trace("- Host : " + j.address);           
						}
					}
				}
			}
			
		}*/
	}
}
