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

https://github.com/renaun/QNXUIExamples/tree/master/DataExampleApp
*/
package
{
import data.DataDelegate;

import events.FilterEvent;
import events.SiteChangeEvent;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import qnx.ui.buttons.Button;
import qnx.ui.core.Container;
import qnx.ui.core.ContainerFlow;
import qnx.ui.core.Containment;
import qnx.ui.core.SizeUnit;
import qnx.utils.ImageCache;

import renderers.SiteImage;

import views.ImageContainer;
import views.ListContainer;
import views.MenuContainer;

/**
 * 	Application lists a set of data and displays the
 *  data points on a sample picture area. Then it uses
 *  the 2nd navigation or context menu to all the user
 *  to filter the results.
 *  
 *  Main sample features:
 * 	 - Data loading
 * 	 - List component
 *   - Object pooling for map points
 *   - QNXApplication swipe event
 * 	 - Basic container layout
 * 	 - Image caching across components
 */
public class DataExampleApp extends Sprite
{
	public static var imageCache:ImageCache = new ImageCache();
	
	public function DataExampleApp()
	{
		super();
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		// Layout
		createLayout();
		// Load Data
		loadData();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

	private var listContainer:ListContainer;
	private var imageContainer:ImageContainer;
	private var menuContainer:MenuContainer;
	private var dataDelegate:DataDelegate;
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	Create all the container views and attach them
	 *  to the display list.
	 */
	private function createLayout():void
	{
		listContainer = new ListContainer();
		listContainer.addEventListener(SiteChangeEvent.SITE_CHANGE, siteChangeHandler);
		
		imageContainer = new ImageContainer();
		imageContainer.addEventListener(SiteChangeEvent.SITE_CHANGE, siteChangeHandler);
		
		menuContainer = new MenuContainer();
		menuContainer.addEventListener(FilterEvent.FILTER, filterHandler);
		
		var mainContainer:Container = new Container();
		mainContainer.flow = ContainerFlow.HORIZONTAL;
		mainContainer.addChild(listContainer);
		mainContainer.addChild(imageContainer);
		mainContainer.addChild(menuContainer);
		addChild(mainContainer);
		mainContainer.setSize(1024, 600);
	}
	
	/**
	 * 	Make the request to load the data
	 */
	private function loadData():void
	{
		if (!dataDelegate)
		{
			dataDelegate = new DataDelegate();
			dataDelegate.addEventListener(Event.COMPLETE, loadedHandler);
		}
		dataDelegate.load();
	}
	
	/**
	 * 	Apply the new loaded data
	 */
	private function loadedHandler(event:Event):void
	{
		listContainer.setData(dataDelegate.currentData);
		imageContainer.setData(dataDelegate.currentData);
	}
	
	/**
	 * 	Handle selecting a site on the image
	 */
	private function siteChangeHandler(event:SiteChangeEvent):void
	{
		if (event.target is ImageContainer)
			listContainer.selectSite(event.site.index);
		if (event.target is ListContainer)
			imageContainer.selectSite(event.site.index);
	}
	
	/**
	 * 	Filter the data in the views.
	 */
	private function filterHandler(event:FilterEvent):void
	{
		if (event.filterType > 0)
		{
			var filterData:Array = [];
			for (var i:int = 0; i < dataDelegate.currentData.length; i++) 
			{
				if (dataDelegate.currentData[i].data.type == event.filterType)
				{
					var data2:Object = dataDelegate.currentData[i];
					data2.data.index = filterData.length;
					filterData.push(data2);
				}
			}
			
			listContainer.setData(filterData);
			imageContainer.setData(filterData);
		}
		else
		{
			listContainer.setData(dataDelegate.currentData);
			imageContainer.setData(dataDelegate.currentData);
		}
	}
}
}