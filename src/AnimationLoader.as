package  
{
	import com.adobe.serialization.json.JSONParseError;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	
	import flash.net.URLLoader;
	//import com.adobe.serialization.json;
	import flash.net.URLRequest;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class AnimationLoader extends EventDispatcher
	{
		
		/*Loader for JSON*/
		var mLoaderJSON:URLLoader;
		var mAnimations:AnimationBank;
		var mComplete:Boolean;
		var mGame:PlayState;
		var fileStream:FileStream;
		public function AnimationLoader(game:PlayState) 
		{
			mComplete = false;
			mGame = game;
		}
		
		public function loadBankFromFile(fileStr:String):void
		{
			//file = mGame.getResources().getPath(file);
			if (mGame.getResources().hasAnimationBank(fileStr))
			{
				mAnimations = mGame.getResources().getAnimationBank(fileStr);
				mComplete = true;
				dispatchEvent(new Event(Event.COMPLETE, false, false));
				return;
			}
			
			mAnimations = new AnimationBank();	
			mAnimations.Path = fileStr;
			mLoaderJSON = new URLLoader();
			/*mLoaderJSON.addEventListener(Event.COMPLETE, onLoadedAnimations);
			mLoaderJSON.addEventListener(IOErrorEvent.IO_ERROR, onError);
			mLoaderJSON.load(new URLRequest(file));*/
			var f:File = new File(File.applicationDirectory.nativePath).resolvePath(fileStr);
			
			fileStream = new FileStream();
			
			if (!f.exists || f.isDirectory)
			{
				var st:String = f.nativePath;
				trace("NOT EXISTING");
			}
			
			var st:String = f.nativePath;
			fileStream.open(f, FileMode.READ);
 	 		fileStream.addEventListener(Event.COMPLETE, onLoadedAnimations);
			mLoaderJSON.data = fileStream.readUTFBytes(fileStream.bytesAvailable);
			onLoadedAnimations(new Event(Event.COMPLETE));
			//mLoaderJSON.data = fileStr.readUTFBytes(fileStr.bytesAvailable);
			//fileStr.close();
		}
		
		public function onError(e:IOErrorEvent):void
		{
			trace(e);
		}
		
		protected function onLoadedAnimations(e:Event):void 
		{
			var data:Object = JSON.parse(mLoaderJSON.data);	
			
			for (var i = 0; i < data.animations.length; i++)
			{
				parseAnimationFromJSONObject(data.animations[i]);
			}
			
			mGame.getResources().addAnimationBank(mAnimations);
			dispatchEvent(new Event(Event.COMPLETE,false,false));
		}
		
		protected function parseAnimationFromJSONObject(obj:Object)
		{
			var res:GameResources = mGame.getResources();//new GameResources();
			//res.initResources();
			
			for (var i = 0; i < obj.clips.length; i++)
			{	
				var clip:AnimationClip = parseAnimationsClipFromJSONOjbect(obj.clips[i], obj.fw, obj.fh);
				
				clip.fps = obj.fps;
				clip.src = res.getResource(obj.img);
				clip.looped = obj.looped == "true";
				
				if (clip.looped == false)
				{
					clip.looped = clip.looped;
				}
				addClip(clip);
			}
		}
		
		protected function addClip(clip:AnimationClip):void {
			mAnimations.addAnimation(clip);
		}
		
		protected function parseAnimationsClipFromJSONOjbect(obj:Object,fw:int,fh:int):AnimationClip
		{
			var clip:AnimationClip = new AnimationClip(obj.name, parseFramesFromJSONClip(obj.frames), fw, fh, null);
			clip.origin.x = obj.origin_x;
			clip.origin.y = obj.origin_y;
			
			return clip;
		}
		
		protected function parseFramesFromJSONClip(strFrames:Object):Array
		{
			var framesArr = new Array();
			var str = new String(strFrames);
			var num = new String("");
			var validStr = new String("01234567890");
			for (var i = 0; i < str.length; i++)
			{
				var ch = str.charAt(i);
				if (ch != ",")
					num += ch;
				else {
					framesArr.push(parseInt(num));
					num = "";
				}
			}
			framesArr.push(parseInt(num));
			
			return framesArr;
		}
		
		public function isComplete():Boolean {
			return mComplete;
		}
		
		public function getAnimationBank():AnimationBank {
			return mAnimations;
		}
		
	}

}