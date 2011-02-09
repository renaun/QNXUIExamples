package events
{
import flash.events.Event;

import vo.SiteVO;

public class SiteChangeEvent extends Event
{
	public static var SITE_CHANGE:String = "siteChange";
	
	public function SiteChangeEvent(siteVO:SiteVO)
	{
		site = siteVO;
		super("siteChange", bubbles, cancelable);
	}
	
	public var site:SiteVO;
}
}