package ahhenderson.core.collections
{

	public class SortedArray
	{
		public var array:Array=[];

		public function add(element:*):int
		{
			 
			var leftIndex:int;
			var rightIndex:int=array.length - 1;
			var middleIndex:int;
			var middleElement:*;

			while (leftIndex <= rightIndex)
			{
				middleIndex=(rightIndex + leftIndex) / 2;
				middleElement=array[middleIndex];
				if (middleElement < element)
				{
					leftIndex=middleIndex + 1;
				}
				else if (middleElement > element)
				{
					rightIndex=middleIndex - 1;
				}
				else
				{
					array.splice(middleIndex, 0, element);
					return middleIndex;
				}
			}
			array.splice(leftIndex, 0, element);
			return leftIndex;
		}

		public function indexOf(element:*):int
		{
			var leftIndex:int;
			var rightIndex:int=array.length - 1;
			var middleIndex:int;
			var middleElement:*;

			while (leftIndex <= rightIndex)
			{
				middleIndex=(rightIndex + leftIndex) / 2;
				middleElement=array[middleIndex];
				if (middleElement < element)
				{
					leftIndex=middleIndex + 1;
				}
				else if (middleElement > element)
				{
					rightIndex=middleIndex - 1;
				}
				else
				{
					return middleIndex;
				}
			}
			return -1;
		}
	}
}
