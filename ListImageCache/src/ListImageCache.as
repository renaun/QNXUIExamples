package
{
	import com.renaun.renderer.CacheImageCellRenderer;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.events.TransformGestureEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import qnx.ui.data.DataProvider;
	import qnx.ui.events.ListEvent;
	import qnx.ui.listClasses.List;
	
	[SWF(frameRate="30", backgroundColor="#000033")]
	public class ListImageCache extends Sprite
	{
		public function ListImageCache()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, stageOrientationChangeHandler);
		}
		
		private var dp:DataProvider = new DataProvider();
		private var list:List;
		private var lblSelected:TextField;
		
		private function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			loadImageData();
		}
		private function stageOrientationChangeHandler(event:Event):void
		{
			// Just going to reset set the list w/h to new stage w/h
			layout();
		}
		
		private function loadImageData():void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadData);
			// Loads a list of MAX images returned as json format
			loader.load(new URLRequest("http://api.flickr.com/services/feeds/photos_public.gne?id=43067655@N07&format=rss2"));
		}
		
		protected function onLoadData(event:Event):void
		{
			var xml:XML = new XML(event.target.data);
			var media:Namespace = new Namespace("http://search.yahoo.com/mrss/");
			
			var xmlList:XMLList = xml..item;
			var len:int = xmlList.length();
			for (var i:int = 0; i<len; i++)
			{
				var obj:Object = new Object();
				obj.text = xmlList[i].media::title+"";
				obj.url = xmlList[i].media::content.@url + "";
				dp.addItem({label:obj.text, data:obj});
			}

			list = new List();
			list.setSkin(CacheImageCellRenderer);
			list.dataProvider = dp;
			list.width = stage.stageWidth;
			list.height = stage.stageHeight;
			list.columnWidth = 240;
			list.rowHeight = 240;
			list.x = 0;
			list.y = 60;
			list.addEventListener(ListEvent.ITEM_CLICKED, itemClickedHandler);
			addChild(list);
			
			var format:TextFormat = new TextFormat();
			format.size = 24;
			format.bold = true;
			format.color = 0xFFFFFF;
			
			lblSelected = new TextField();
			lblSelected.defaultTextFormat = format;
			lblSelected.x = 6;
			lblSelected.y = 6;
			lblSelected.text = "Selected an image!";
			addChild(lblSelected);
			layout();	
		}
		
		private function layout():void
		{
			lblSelected.width = stage.stageWidth-300;
			list.width = 240;
			list.height = stage.stageHeight - list.y;
		}
		
		protected function itemClickedHandler(event:ListEvent):void
		{
			lblSelected.text = "You selected: " + event.data.text;
		}
		
	}
}