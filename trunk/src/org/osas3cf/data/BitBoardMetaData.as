package org.osas3cf.data
{
	import org.osas3cf.core.data.MetaData;
	
	public class BitBoardMetaData extends MetaData
	{
		public static const EVALUATE:String = "EvaluateBitBoard";
		public static const EVALUATED:String 	= "EvaluatedBitBoard";
		public static const UPDATED:String = "UpdatedBitBoard";
		
		public function BitBoardMetaData(type:String, data:Array)
		{
			super(type, data);
		}
		
		override public function toString():String
		{
			return "BitBoardMetaData: {type: "+type+", data: "+data+"}";
		}
	}
}