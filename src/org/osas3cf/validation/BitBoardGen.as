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
package org.osas3cf.validation
{
	import org.osas3cf.data.BitBoard;
	import org.osas3cf.data.BitBoardTypes;
	import org.osas3cf.utility.BitOper;
	import org.osas3cf.utility.Debug;
	import org.osas3cf.validation.rules.IPieceRule;

	public class BitBoardGen
	{
		private var colors:Array = [];
		private var ruleSets:Array = [];
		
		public function BitBoardGen(ruleSets:Array, colors:Array)
		{
			this.ruleSets = ruleSets;
			this.colors = colors;
		}
		
		public function execute(board:BitBoard):Array
		{
			if(!board)return null;
			var bitBoards:Array = [];
			bitBoards[BitBoardTypes.BOARD] = board;
			updateBitBoards(bitBoards);
			return bitBoards;
		}
		
		private function updateBitBoards(bitBoards:Array):void
		{	
			CONFIG::debug{Debug.out("Calculating new bit boards", this)}
			//Update color boards
			for each(var color:String in colors)
			{
				bitBoards[color + BitBoardTypes.S] = BitOper.contains(bitBoards[BitBoardTypes.BOARD], color);
				bitBoards[color + BitBoardTypes.ATTACK] = new BitBoard();
			}
			//Update piece boards
			for each(var ruleSet:IPieceRule in ruleSets)
			{
				bitBoards[ruleSet.name + BitBoardTypes.S] = BitOper.contains(bitBoards[BitBoardTypes.BOARD], ruleSet.name);
			}
			//Update attack and move boards
			for(var index:String in ruleSets)
			{
				IPieceRule(ruleSets[index]).execute(bitBoards);
			}
		}
	}
}