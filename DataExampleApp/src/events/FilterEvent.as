package events
{
import flash.events.Event;

public class FilterEvent extends Event
{
	public static var FILTER:String = "filter";
	
	public function FilterEvent(type:int)
	{
		this.filterType = type;
		super("filter", bubbles, cancelable);
	}
	
	public var filterType:int;
}
}