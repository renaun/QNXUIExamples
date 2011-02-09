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
package renderers
{
import flash.display.GradientType;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import qnx.ui.display.Image;
import qnx.ui.listClasses.CellRenderer;
import qnx.ui.text.Label;

import vo.SiteVO;

public class ListItemRenderer extends CellRenderer
{
	public function ListItemRenderer()
	{
		super();
	}
	
	/**
	 *  
	 */
	protected var img:Image;
	protected var lblName:Label;
	protected var lblLocation:Label;
	protected var bg:Sprite;
	protected var format:TextFormat;
	
	/**
	 *  Updates the text and image everytime a new data is set
	 *  for this renderer instance.
	 */
	override public function set data(value:Object):void
	{
		super.data = value.data;
		updateCell();
	}
	
	/**
	 *  Update the image and text if there is valid data.
	 */
	private function updateCell():void
	{
		if (this.data && data is SiteVO)
		{
			var siteVO:SiteVO = data as SiteVO;
			//trace("loading: " + data.url);
			img.setImage("assets/" + siteVO.icon);
			lblName.text = data.name;
			lblLocation.text = "Loc: " + data.locationX + "/" + data.locationY;
		}      
	}
	
	/**
	 * 	Handle drawing the background based on selected or not selected state 
	 */
	override protected function setState(state:String):void
	{
		super.setState(state);
		var alpha:Number = 0.5;
		if (state == "selected")
		{
			alpha = 0.3;
		}
		bg.graphics.clear();
		bg.graphics.beginGradientFill(GradientType.LINEAR, 
			[0x000000, 0x000000], [alpha, alpha/2], [0,254]);
		bg.graphics.drawRect(0, 0, width, height);
		bg.graphics.endFill();
		bg.graphics.lineStyle(2, 0x222222);
		bg.graphics.moveTo(0, height-1);
		bg.graphics.lineTo(width-1, height-1);
		bg.graphics.lineTo(width-1, 0);
	}
	
	/**
	 *  Create all the cell renderer components just once
	 */
	override protected function init():void
	{
		img = new Image();
		lblName = new Label();
		lblLocation = new Label();
		bg = new Sprite();
		
		format = new TextFormat();
		format.color = 0x333333;
		format.size = 20;
		format.bold = true;
				
		img.setPosition(4,7);
		img.setSize(30,41);
		img.cache = DataExampleApp.imageCache;
		
		lblName.format = format;
		lblName.x = 38;
		lblName.y = 5;
		lblName.autoSize = TextFieldAutoSize.LEFT;
		lblName.filters = [new DropShadowFilter(2)];
		
		format.size = 12;
		lblLocation.format = format;
		lblLocation.x = 38;
		lblLocation.y = 34;
		lblLocation.autoSize = TextFieldAutoSize.LEFT;
		
		addChild(bg);
		addChild(img);
		addChild(lblName);
		addChild(lblLocation);
	}
}
}