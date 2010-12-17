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

	public class BitOper
	{
		public function BitOper()
		{
			throw new IllegalOperationError("BitOper class should never be initalized as there are no BitOper objects in OSAS3CF");
		}
		
		public static function contains(array:Array, value:String):Array
		{
			var result:Array = [];
			var recursive:Array;
			for(var i:String in array)
			{
				if(array[i] is String || array[i] is Number){
					if(String(array[i]).indexOf(value) != -1)
						result[i] = 1;
					else
						result[i] = 0;
				}else{
					recursive = BitOper.contains(array[i], value);
					if(recursive.length > 0)
						result[i] = recursive;
				}
			}
			return result;
		}
		
		public static function doesNotContain(array:Array, value:String):Array
		{
			var result:Array = [];
			var recursive:Array;
			for(var i:String in array)
			{
				if(array[i] is String || array[i] is Number){	
					if(String(array[i]).indexOf(value) == -1){
						result[i] = 1;
				}	else
						result[i] = 0;
				}else{
					recursive = BitOper.doesNotContain(array[i], value);
					if(recursive.length > 0)
						result[i] = recursive;
				}
			}
			return result;
		}	
			
		public static function and(arrayA:Array, arrayB:Array):Array
		{
			var result:Array = [];
			var recursive:Array;
			if(arrayA.length != arrayB.length) return result;
			for(var i:String in arrayA)
			{
				if((arrayA[i] is Number && arrayB[i] is Number) || (arrayA[i] is String && arrayB[i] is String)){
					if(String(arrayA[i]) != "0" && String(arrayB[i]) != "0")
						result[i] = 1;
					else
						result[i] = 0;
				}else{
					recursive = BitOper.and(arrayA[i], arrayB[i]);
					if(recursive.length > 0)
						result[i] = recursive;
				}	
			}
			return result;
		}
		
		public static function or(arrayA:Array, arrayB:Array):Array
		{
			var result:Array = [];
			var recursive:Array;
			if(arrayA.length != arrayB.length) return result;
			for(var i:String in arrayA)
			{
				if((arrayA[i] is Number && arrayB[i] is Number) || (arrayA[i] is String && arrayB[i] is String)){
					if(String(arrayA[i]) != "0" || String(arrayB[i]) != "0")
						result[i] = 1;
					else
						result[i] = 0;
				}else{
					recursive = BitOper.or(arrayA[i], arrayB[i]);
					if(recursive.length > 0)
						result[i] = recursive;
				}	
			}
			return result;
		}
		
		public static function not(arrayA:Array):Array
		{
			var result:Array = [];
			var recursive:Array;
			for(var i:String in arrayA)
			{
				if(arrayA[i] is Number || arrayA[i] is String){
					if(String(arrayA[i]) == "0")
						result[i] = 1;
					else
						result[i] = 0;
				}else{
					recursive = BitOper.not(arrayA[i]);
					if(recursive.length > 0)
						result[i] = recursive;
				}	
			}
			return result;
		}

		public static function notX(arrayA:Array, arrayB:Array):Array
		{
			var result:Array = [];
			var recursive:Array;
			if(arrayA.length != arrayB.length) return result;
			for(var i:String in arrayA)
			{
				if((arrayA[i] is Number && arrayB[i] is Number) || (arrayA[i] is String && arrayB[i] is String)){
					if(String(arrayA[i]) == "0" || String(arrayB[i]) == "0")
						result[i] = 1;
					else
						result[i] = 0;
				}else{
					recursive = BitOper.notX(arrayA[i], arrayB[i]);
					if(recursive.length > 0)
						result[i] = recursive;
				}	
			}
			return result;
		}		
	}
}