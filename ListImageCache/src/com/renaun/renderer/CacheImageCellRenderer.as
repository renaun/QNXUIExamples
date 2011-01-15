package com.renaun.renderer
{
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import qnx.ui.display.Image;
import qnx.ui.listClasses.CellRenderer;
import qnx.ui.text.Label;
import qnx.utils.ImageCache;

public class CacheImageCellRenderer extends CellRenderer
{
	/**
	 * 	This is a static cache object. Alternatively you can 
	 *  create this object out side this class to be used
	 *  in more then one place.
	 */
	public static var cacheObject:ImageCache = new ImageCache();
	
	public function CacheImageCellRenderer()
	{
		super();
		initBackground();
	}
	
	/**
	 * 	
	 */
	protected var img:Image;
	protected var lbl:Label;
	protected var bg:Sprite;
	protected var format:TextFormat;
	
	/**
	 * 	Updates the text and image everytime a new data is set
	 *  for this renderer instance.
	 */
	override public function set data(value:Object):void
	{
		super.data = value.data;
		//trace(value.data.text + " - " + value.data.url);
		updateCell();
	}
	
	/**
	 * 	Update the image and text if there is valid data.
	 */
	private function updateCell():void
	{
		if (this.data)
		{
			//trace("loading: " + data.url);
			img.setImage(data.url);
			lbl.text = data.text;
		}		
	}
	
	/**
	 * 	Create all the cell renderer components just once
	 */
	private function initBackground():void
	{
		img = new Image();
		lbl = new Label();
		bg = new Sprite();
		
		format = new TextFormat();
		format.color = 0xEEEEEE;
		format.size = 12;
		format.bold = true;
		
		bg.graphics.clear();
		bg.graphics.beginFill(0x000000, .7);
		bg.graphics.drawRect(0, 0, 240, 50);
		bg.graphics.endFill();
		img.setPosition(0,0);
		img.setSize(240,134);
		// Setting the cache propery on QNX Image class
		// takes care of adding and checking for images on
		// the ImageCache object.
		img.cache = CacheImageCellRenderer.cacheObject;
		
		lbl.width = 240;
		lbl.format = format;
		lbl.wordWrap = true;
		lbl.x = 5;
		lbl.y = 0;
		lbl.width = 220;
		lbl.autoSize = TextFieldAutoSize.LEFT;
		
		addChild(img);
		addChild(bg);
		addChild(lbl);
	}
}
}