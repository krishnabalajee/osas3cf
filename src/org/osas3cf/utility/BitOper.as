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
package org.osas3cf.utility
{
	import flash.errors.IllegalOperationError;
	/**
	 * BitOper provides a set of utility methods like C/C++'s AND - OR - NOT bit operators to work with arrays acting as bitboards.  The class only contains
	 * static methods that can be used anywere in the OSAS3CF.  The methods are built to evaluate BitBoards which
	 * is a 8x8 multidemensional array that represents that chess board.  The indices mostly contain strings 1 or 0, 
	 * representing boolean values.  The BitBoards represent different board states like piece positioins and attacks.
	 * The BitOper utiliy helps evalutate the information that is contained in the bitboard for analysis and move/rule validation.
	 **/
	public class BitOper
	{
		/**
		 * BitOper should only be used as a static class and should never be initalized.
		 * @constructor
		 * @throws IllegalOpertaionError Prevents user from initalizing any BitOper class.
		 **/
		public function BitOper()
		{
			throw new IllegalOperationError("BitOper class should never be initalized as there are no BitOper objects in OSAS3CF");
		}
		
		/**
		 * Searches the given array for the given value, if the index does contain the value the result will be '1' and
		 * '0' if no mataches are found.
		 * @param array to be evaluated, can be a multideminsion array.
		 * @param value the string that will result in a true index.
		 * @returns Result array of operation containing '1' or '0'.
		 **/
		public static function contains(array:Array, value:String):Array
		{
			var result:Array = [];
			for(var i:String in array)
			{	
				if(array[i] is Array)
					result[i] = BitOper.contains(array[i], value);				
				else if(String(array[i]).indexOf(value) != -1)
					result[i] = 1;				
				else
					result[i] = 0;
			}
			return result;
		}
		
		/**
		 * Searches the given array for the given value, if the index does contain the value the result will be '0' and
		 * '1' if no mataches are found.
		 * @param array to be evaluated, can be a multideminsion array.
		 * @param value the string that will result in a false index.
		 * @returns Result array of operation containing '1' or '0'.
		 **/		
		public static function doesNotContain(array:Array, value:String):Array
		{
			var result:Array = [];
			for(var i:String in array)
			{
				if(array[i] is Array)
					result[i] = BitOper.doesNotContain(array[i], value);				
				else if(String(array[i]).indexOf(value) == -1)
					result[i] = 1;
				else
					result[i] = 0;
			}
			return result;
		}
		
		/**
		 * Takes two arrays and compares each index, if both indices are true the result will be true. If both indices are
		 * not true the result will be false.  Multidemenisional arrays are accepted, but arrayA and arrayB need to be the 
		 * same size or the result will be faulty.
		 * @param arrayA array to compare.
		 * @param arrayB array to compare.
		 * @returns Result array of operation containing '1' or '0'.
		 **/
		public static function and(arrayA:Array, arrayB:Array):Array
		{
			var result:Array = [];
			if(arrayA.length != arrayB.length) return result;
			for(var i:String in arrayA)
			{
				if(arrayA[i] is Array && arrayB[i] is Array)
					result[i] = BitOper.and(arrayA[i], arrayB[i]);			
				else if(arrayA[i] != 0 && arrayB[i] != 0)
					result[i] = 1;
				else
					result[i] = 0;	
			}
			return result;
		}
		
		/**
		 * Takes two arrays and compares each index, if one index is true the result will be true. If both indices are
		 * not true the result will be false.  Multidemenisional arrays are accepted, but arrayA and arrayB need to be the 
		 * same size or the result will be faulty.
		 * @param arrayA array to compare.
		 * @param arrayB array to compare.
		 * @returns Result array of operation containing '1' or '0'.
		 **/		
		public static function or(arrayA:Array, arrayB:Array):Array
		{
			var result:Array = [];
			if(arrayA.length != arrayB.length) return result;
			for(var i:String in arrayA)
			{
				if(arrayA[i] is Array && arrayB[i] is Array)
					result[i] = BitOper.or(arrayA[i], arrayB[i]);				
				else if(arrayA[i] != 0 || arrayB[i] != 0)
					result[i] = 1;
				else
					result[i] = 0;
			}
			return result;
		}
		
		/**
		 * Reverses the arrays index values, '1' become '0' and '0' become '1'.  
		 * @param array to be evaluated, can be a multideminsion array.
		 * @returns Result array of operation containing '1' or '0'.
		 **/
		public static function not(array:Array):Array
		{
			var result:Array = [];
			for(var i:String in array)
			{
				if(array[i] is Array)
					result[i] = BitOper.not(array[i]);			
				else if(array[i] == 0)
					result[i] = 1;					
				else
					result[i] = 0;
			}
			return result;
		}
		
		/**
		 * @private
		 **/
		public static function notX(arrayA:Array, arrayB:Array):Array
		{
			var result:Array = [];
			if(arrayA.length != arrayB.length) return result;
			for(var i:String in arrayA)
			{
				if(arrayA[i] is Array && arrayB[i] is Array)
					result[i] = BitOper.notX(arrayA[i], arrayB[i]);			
				else if(arrayA[i] == 0 || arrayB[i] == 0)
					result[i] = 1;
				else
					result[i] = 0;	
			}
			return result;
		}
		
		/**
		 * Finds the number of indices that are true in the aray. A true index contains a string that is
		 * something other than '0' which is used to indicate an false index.
		 * @param array to be evaluated, can be a multideminsion array.
		 * @returns Number of indices that are true.
		 **/ 
		public static function sum(array:Array):Number
		{
			var result:Number = 0;
			for(var i:String in array)
			{
				if(array[i] is Array)
					result += BitOper.sum(array[i]);
				else if(array[i] != 0)
					result ++
			}
			return result;			
		}
	}
}