/**
 * The MIT License
 * Copyright (c) 2010 Craig Simpson
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 **/
package org.osas3cf.data.metadata
{
	import org.osas3cf.core.data.MetaData;
	import org.osas3cf.data.vo.MoveVO;

	public class MoveMetaData extends MetaData
	{
		public static const SUBMIT_MOVE:String 		= "SubmitMove";
		public static const INVALID_MOVE:String 	= "InvalidMove";
		public static const MOVE_PIECE:String 		= "MovePiece";
		
		public static const CAPTURE_PIECE:String 	= "CapturePiece";
		public static const PROMOTE_PIECE:String 	= "PromotePiece";
		
		public static const CHECK:String = "Check";
		public static const CHECKMATE:String = "Checkmate";
		public static const STALEMATE:String = "Stalemate";
		public static const DRAW:String = "Draw";
		
		public function MoveMetaData(type:String, vo:MoveVO = null)
		{
			super(type, vo);
		}	
	}
}