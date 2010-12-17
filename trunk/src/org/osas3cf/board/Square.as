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
package org.osas3cf.board
{
	import flash.errors.IllegalOperationError;

	public class Square
	{
		public static var A1:String = "A1";
		public static var A2:String = "A2";
		public static var A3:String = "A3";
		public static var A4:String = "A4";
		public static var A5:String = "A5";
		public static var A6:String = "A6";
		public static var A7:String = "A7";
		public static var A8:String = "A8";
		
		public static var B1:String = "B1";
		public static var B2:String = "B2";
		public static var B3:String = "B3";
		public static var B4:String = "B4";
		public static var B5:String = "B5";
		public static var B6:String = "B6";
		public static var B7:String = "B7";
		public static var B8:String = "B8";
		
		public static var C1:String = "C1";
		public static var C2:String = "C2";
		public static var C3:String = "C3";
		public static var C4:String = "C4";
		public static var C5:String = "C5";
		public static var C6:String = "C6";
		public static var C7:String = "C7";
		public static var C8:String = "C8";
		
		public static var D1:String = "D1";
		public static var D2:String = "D2";
		public static var D3:String = "D3";
		public static var D4:String = "D4";
		public static var D5:String = "D5";
		public static var D6:String = "D6";
		public static var D7:String = "D7";
		public static var D8:String = "D8";		
		
		public static var E1:String = "E1";
		public static var E2:String = "E2";
		public static var E3:String = "E3";
		public static var E4:String = "E4";
		public static var E5:String = "E5";
		public static var E6:String = "E6";
		public static var E7:String = "E7";
		public static var E8:String = "E8";		
		
		public static var F1:String = "F1";
		public static var F2:String = "F2";
		public static var F3:String = "F3";
		public static var F4:String = "F4";
		public static var F5:String = "F5";
		public static var F6:String = "F6";
		public static var F7:String = "F7";
		public static var F8:String = "F8";	
		
		public static var G1:String = "G1";
		public static var G2:String = "G2";
		public static var G3:String = "G3";
		public static var G4:String = "G4";
		public static var G5:String = "G5";
		public static var G6:String = "G6";
		public static var G7:String = "G7";
		public static var G8:String = "G8";		
		
		public static var H1:String = "H1";
		public static var H2:String = "H2";
		public static var H3:String = "H3";
		public static var H4:String = "H4";
		public static var H5:String = "H5";
		public static var H6:String = "H6";
		public static var H7:String = "H7";
		public static var H8:String = "H8";			
		
		public function Square()
		{
			throw new IllegalOperationError("Square class should never be initalized as there are no square objects in OSAS3CF");
		}
	}
}