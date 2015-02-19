
package ahhenderson.core.managers.dependency.objectPool.interfaces {
	import ahhenderson.core.collections.interfaces.IEnumeration;

	public interface IPoolType extends IEnumeration {

		/**
		 * Class that pool is create for
		 *
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 11
		 *  @playerversion AIR 3
		 *  @productversion Starling 1.2, Flex 4.6 
		 */
		
		function get objClass():Class;
		
	 
		  
	}
}
