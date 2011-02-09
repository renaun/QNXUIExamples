/*
Copyright (c) 2011 Renaun Erickson (http://renaun.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package data
{
import flash.events.Event;
import flash.events.EventDispatcher;

import vo.SiteVO;

	
/**
 *  Dispatched when the data is loaded.
 *
 *  @eventType flash.events.Event.COMPLETE
 *  
 */
[Event(name="complete", type="flash.events.Event")]	
	
public class DataDelegate extends EventDispatcher
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	public var currentData:Array;
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

	/**
	 * 	Load data, this encapsulates the actual location where
	 *  the data is loaded from. Once the data is loaded into 
	 *  the currentData array the class fires off a COMPLETE event.
	 */
	public function load():void
	{
		// Generated data but this could be read from a file
		var data2:Array = [];
		var obj:SiteVO;
		for (var i:int = 0; i < 50; i++) 
		{
			var rand:int = (Math.random() * 0xffffff);
			obj = new SiteVO();
			obj.type = int(rand % 3) + 1;
			obj.icon = ((rand % 2 == 0) ? "arrow" : "source") + obj.type + ".png";
			obj.index = i;
			obj.locationX = (rand % 740) + 30; // Make sure within 30px of sides
			rand = (Math.random() * 0xffffff);
			obj.locationY = (rand % 540) + 30; // Make sure within 30px of sides
			obj.name = "Site #" + int(rand % 99999);
			data2.push({label: obj.name, data: obj});
		}
		currentData = data2;
		dispatchEvent(new Event(Event.COMPLETE));
	}
}
}