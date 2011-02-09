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
import caurina.transitions.Tweener;

import events.FilterEvent;

import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.utils.setInterval;

import qnx.events.QNXApplicationEvent;
import qnx.system.QNXApplication;
import qnx.ui.buttons.Button;
import qnx.ui.core.Container;
import qnx.ui.core.ContainerAlign;
import qnx.ui.core.ContainerFlow;
import qnx.ui.core.Containment;
import qnx.ui.core.SizeUnit;
import qnx.ui.display.Image;
import qnx.ui.events.ListEvent;

import renderers.SiteImage;

import vo.SiteVO;


/**
 *  Dispatched when a data filter is selected.
 *
 *  @eventType events.FilterEvent.FILTER
 *  
 */
[Event(name="filter", type="events.FilterEvent")]

/**
 * 	The container that holds the menu logic and hooks
 *  into the QNXApplication swipe down.
 */
public class MenuContainer extends Container
{
	public function MenuContainer()
	{
		y = -82;
		//debugColor = 0xFF0000;
		containment = Containment.UNCONTAINED;
		QNXApplication.qnxApplication.addEventListener(QNXApplicationEvent.SWIPE_DOWN, swipeHandler);
		createChildren();
		setSize(1024, 60);
	}

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var isVisible:Boolean = false;
	private var imageType1:Image;
	private var imageType2:Image;
	private var imageType3:Image;
	private var currentImage:Image;
	private var glow:GlowFilter = new GlowFilter(0xAA3333, 0.8, 10, 10, 6);
	
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
		graphics.beginFill(0xDDDDDD, 0.9);
		graphics.drawRect(0, 0, 1024, 80);
		graphics.endFill();
		graphics.lineStyle(2,0x000000);
		graphics.moveTo(0, 80);
		graphics.lineTo(1024, 80);
		graphics.lineStyle(2,0x000000, 0.3);
		graphics.moveTo(0, 81);
		graphics.lineTo(1024, 81);
		
		
		if (!imageType1)
		{
			imageType1 = new Image();
			imageType1.cache = DataExampleApp.imageCache;
			imageType1.setImage("assets/source1.png");
			imageType1.addEventListener(MouseEvent.CLICK, imgClickHandler);
			imageType1.containment = Containment.UNCONTAINED;
			imageType1.setPosition(1024/4, 15);
			addChild(imageType1);
		}
		if (!imageType2)
		{
			imageType2 = new Image();
			imageType2.cache = DataExampleApp.imageCache;
			imageType2.setImage("assets/source2.png");
			imageType2.addEventListener(MouseEvent.CLICK, imgClickHandler);
			imageType2.containment = Containment.UNCONTAINED;
			imageType2.setPosition(1024/2, 15);
			addChild(imageType2);
		}
		if (!imageType3)
		{
			imageType3 = new Image();
			imageType3.cache = DataExampleApp.imageCache;
			imageType3.setImage("assets/source3.png");
			imageType3.addEventListener(MouseEvent.CLICK, imgClickHandler);
			imageType3.containment = Containment.UNCONTAINED;
			imageType3.setPosition(1024*3/4, 15);
			addChild(imageType3);
		}
	}
	
	/**
	 * 	Selecting a site and need to send event.
	 */
	private function imgClickHandler(event:MouseEvent):void
	{
		if (currentImage)
			currentImage.filters = [];
		if (currentImage == event.target)
		{
			dispatchEvent(new FilterEvent(0));
			currentImage = null;
			return;
		}
		else if (event.target == imageType1)
			dispatchEvent(new FilterEvent(1));
		else if (event.target == imageType2)
			dispatchEvent(new FilterEvent(2));
		else if (event.target == imageType3)
			dispatchEvent(new FilterEvent(3));
		currentImage = event.target as Image;
		currentImage.filters = [glow];
	}
	
	/**
	 * 	Handle the swipe down events
	 */
	private function swipeHandler(event:QNXApplicationEvent):void
	{
		if (!isVisible)
			Tweener.addTween(this, {y: 0, time:1.7});
		else
			Tweener.addTween(this, {y: -82, time:1.7});
		isVisible = !isVisible;
	}
}
}