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

import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;

import qnx.ui.core.Container;
import qnx.ui.core.ContainerAlign;
import qnx.ui.core.SizeUnit;
import qnx.ui.data.DataProvider;
import qnx.ui.display.Image;

import renderers.SiteImage;

/**
 *  Dispatched when a site has been selected.
 *
 *  @eventType events.SiteChangeEvent.SITE_CHANGE
 *  
 */
[Event(name="siteChange", type="events.SiteChangeEvent")]

public class ImageContainer extends Container
{
	public function ImageContainer()
	{
		//debugColor = 0x0000FF;
		align = ContainerAlign.NEAR;
		createChildren();
	}

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var image:Image;
	private var availableSiteImages:Array = [];
	private var currentSiteImages:Array = [];
	private var glow:GlowFilter;
	private var currentSelected:SiteImage;
	
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
		if (!image)
		{
			image = new Image();
			image.setImage("assets/area.jpg");
			addChild(image);
		}
		if (!glow)
		{
			glow = new GlowFilter(0xAA3333, 0.8, 10, 10, 6);
		}
	}
	
	/**
	 * 	Set the data for this view
	 */
	public function setData(data:Array):void
	{
		var img:SiteImage;
		// Remove objects
		while (currentSiteImages.length > 0) 
		{
			img = currentSiteImages.pop();
			availableSiteImages.push(img);
			removeChild(img);
		}
		
		// Add objects
		for (var i:int = 0; i < data.length; i++) 
		{
			img = getSiteImage();
			img.setData(data[i].data);
			currentSiteImages.push(img);
			addChild(img);
		}
	}
	
	/**
	 * 	Return SiteImage instance from pool of objects.
	 */
	private function getSiteImage():SiteImage
	{
		var img:SiteImage;
		// If we are out of our pool create 5 more
		if (availableSiteImages.length == 0)
		{
			for (var i:int = 0; i < 5; i++) 
			{
				img = new SiteImage();
				img.cache = DataExampleApp.imageCache;
				img.addEventListener(MouseEvent.CLICK, siteClickHandler);
				availableSiteImages.push(img);
			}
		}
		return availableSiteImages.pop();
	}
	
	/**
	 *  Handle clicks on the images.
	 */
	private function siteClickHandler(event:MouseEvent):void
	{
		event.stopPropagation();
		var siteImg:SiteImage = event.target as SiteImage;
		selectSiteImage(siteImg);
		// Fire Select Event
		
		dispatchEvent(new SiteChangeEvent(siteImg.data));
	}
	
	/**
	 * 	Allow view to change based upon a selected item.
	 */
	public function selectSite(selectedIndex:int):void
	{
		for (var i:int = 0; i < currentSiteImages.length; i++) 
		{
			if (currentSiteImages[i].data.index == selectedIndex)
			{
				selectSiteImage(currentSiteImages[i]);
				return;
			}
		}
	}

	/**
	 * 	Set the glow state for the selected site image.
	 */
	public function selectSiteImage(site:SiteImage):void
	{
		if (currentSelected)
			currentSelected.filters = [];
		currentSelected = site;
		// Set the glow filter
		currentSelected.filters = [glow];
	}
}
}