//------------------------------------------------------------------------------
//
//  
//  Copyright 2012 by Anthony Henderson   
//  All rights reserved.  
//  
//
//------------------------------------------------------------------------------
 
package ahhenderson.core.mvc.enums {
	import avmplus.getQualifiedClassName;
	
	import ahhenderson.core.collections.interfaces.IEnumeration;

	 
	public final class ActorType implements IEnumeration{

		public static const MODEL:ActorType=new ActorType("MODEL");
		
		public static const MEDIATOR:ActorType=new ActorType("MEDIATOR");
		
		public static const COMMAND:ActorType=new ActorType("COMMAND");
		

		private static var locked:Boolean=false;
		
		{
			locked=true;
		}

		private var _value:String;
		
		public function ActorType(value:String):void {
			if (locked) {
				throw new Error("The " + getQualifiedClassName(this) + " class is not instantiable.");
			}
			_value=value;
		}

		private var _globalMessageActionEnum:String;

		 
		
		public function get value():String
		{ 
			return _value;
		}
		
	}
}
