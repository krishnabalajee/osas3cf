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
	import flash.geom.Point;
	
	public class BoardUtil
	{
		public function BoardUtil()
		{
			throw new IllegalOperationError("BoardUtil class should never be initalized as there are no BoardUtil objects in OSAS3CF");
		}
		
		public static function squareToArrayNote(square:String):Point
		{
			return new Point(Number(square.charCodeAt(0) - String("A").charCodeAt(0)), Number(square.charAt(1)) - 1);
		}
		
		public static function arrayNoteToSquare(point:Point):String
		{
			return String.fromCharCode(point.x + String("A").charCodeAt(0)) + String(point.y + 1);
		}
	}
}