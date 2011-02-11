package
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.ErrorEvent;
import flash.filesystem.File;
import flash.text.TextField;
import flash.text.TextFormat;

import qnx.events.MediaPlayerEvent;
import qnx.media.MediaPlayer;
import qnx.media.VideoDisplay;

public class Media1 extends Sprite
{
	private var mp:MediaPlayer;// = new MediaPlayer();
	private var video:VideoDisplay;// = new VideoDisplay();
	private var output:TextField;
	public function Media1()
	{
		super();
		
		// support autoOrients
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		var format:TextFormat = new TextFormat();
		format.size = 12;
		format.color = 0x0000ff;
		output = new TextField();
		output.multiline = true;
		output.width = 1024;
		output.height = 500;
		output.defaultTextFormat = format;
		addChild(output);
		
		//
		video = new VideoDisplay(false);
		video.backgroundColor = 0xff0000;
		video.x = 200;
		video.width = 800;
		video.height = 600;
		addChild(video);
		
		//var murl:String = File.applicationDirectory.resolvePath("music/PianoSong.mp3").nativePath;
		var murl:String = "file://" + File.applicationDirectory.resolvePath("video/MainConcept.mp4").nativePath;
		output.text = murl + "\n";
		output.appendText("MainConcept.mp4\n");
		mp = new MediaPlayer(murl, video);
		//mp.url = murl;
		//mp.videoDisplay = video;
		mp.addEventListener(ErrorEvent.ERROR, errorHandler);
		mp.addEventListener(MediaPlayerEvent.PREPARE_COMPLETE, mediaPlayerHandler);
		mp.addEventListener(MediaPlayerEvent.INFO_CHANGE, mediaPlayerHandler);
		mp.addEventListener(MediaPlayerEvent.BUFFER_CHANGE, mediaPlayerHandler);
		mp.addEventListener(MediaPlayerEvent.RESET_COMPLETE, mediaPlayerHandler);
		mp.play();
	}
	
	private function errorHandler(event:ErrorEvent):void
	{
		output.text += event.type + ": " + event.text+"\n";
	}
	
	private function mediaPlayerHandler(event:MediaPlayerEvent):void
	{
		
		output.appendText(event.type + ": ");
		for(var key:String in event.what)
			output.appendText(" " + key + ": " + mp[key]);
		output.appendText("\n");
	}
}
}