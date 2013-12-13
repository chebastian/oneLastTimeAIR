package  
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class ExternalBitmap 
	{
		
		var mBitmapData:Bitmap;
		var uniqueId:String;
		var mFinished:Boolean;
		var mOnComplete:Function;
		
		public function ExternalBitmap(onComplete:Function)
		{
			mFinished = false;
			mOnComplete = onComplete;
		}
		
		public function load(path:String):void
		{
			this.uniqueId = path;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
			loader.load(new URLRequest(this.uniqueId));
		}
		
		public function onLoad(e:Event):void
		{
			mFinished = true;
			mBitmapData = Bitmap(LoaderInfo(e.target).content);
			mOnComplete(this);
		}
		
	}

}