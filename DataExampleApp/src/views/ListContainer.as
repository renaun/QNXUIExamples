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
package views
{
import events.SiteChangeEvent;

import qnx.ui.core.Container;
import qnx.ui.core.SizeUnit;
import qnx.ui.data.DataProvider;
import qnx.ui.events.ListEvent;
import qnx.ui.listClasses.List;
import qnx.ui.listClasses.ListSelectionMode;

import renderers.ListItemRenderer;

import vo.SiteVO;


/**
 *  Dispatched when a site has been selected.
 *
 *  @eventType events.SiteChangeEvent.SITE_CHANGE
 *  
 */
[Event(name="siteChange", type="events.SiteChangeEvent")]

public class ListContainer extends Container
{
	public function ListContainer()
	{
		size = 224;
		sizeUnit = SizeUnit.PIXELS;
		//debugColor = 0xFF0000;
		createChildren();
	}

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var list:List;
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

	/**
	 * 	Create the view contents
	 */
	public function createChildren():void
	{
		if (!list)
		{
			list = new List();
			list.columnWidth = 224;
			list.rowHeight = 60;
			list.size = 100;
			list.sizeUnit = SizeUnit.PERCENT;
			list.setSkin(ListItemRenderer);
			list.selectionMode = ListSelectionMode.SINGLE;
			list.allowDeselect = true;
			list.addEventListener(ListEvent.ITEM_CLICKED, listItemClickedHandler);
			addChild(list);
		}
	}
	
	/**
	 * 	Set the data for this view
	 */
	public function setData(data:Array):void
	{
		list.dataProvider = new DataProvider(data);
	}
	
	/**
	 * 	Allow view to change based upon a selected item.
	 */
	public function selectSite(selectedIndex:int):void
	{
		list.scrollToIndex(selectedIndex);
		list.selectedIndex = selectedIndex;
	}
	
	/**
	 * 	Selecting a site and need to send event.
	 */
	private function listItemClickedHandler(event:ListEvent):void
	{
		dispatchEvent(new SiteChangeEvent(event.data as SiteVO));
	}
}
}