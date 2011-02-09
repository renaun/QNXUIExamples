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
import qnx.ui.display.Image;

import vo.SiteVO;

/**
 * 	Image class that is aware of SiteVO data to display
 *  the correct image and location.
 */
public class SiteImage extends Image
{
	
	public var data:SiteVO;
	
	/**
	 * 	Set the image source and location.
	 */
	public function setData(data:SiteVO):void
	{
		this.data = data;
		setImage("assets/" + data.icon);
		x = data.locationX - 15;
		y = data.locationY - 20;
	}
	
	/**
	 * 	Get the site index
	 */
	public function getSiteIndex():int
	{
		if (data)
			return data.index;
		else
			return 0;
	}
}
}