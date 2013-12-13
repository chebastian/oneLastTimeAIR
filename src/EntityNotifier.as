package  
{
	import org.flixel.system.FlxList;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EntityNotifier 
	{
		var mListeners:Vector.<EntityObserver>;
		var mLastTime:uint;
		var mTimeBetweenNotifications:uint;

		public function EntityNotifier() 
		{
			mListeners = new Vector.<EntityObserver>();
			mTimeBetweenNotifications = 0;
			mLastTime = 0;
		}
			
		public function registerObserver(listener:EntityObserver) 
		{
			mListeners.push(listener);
		}
		
		public function unregisterObserver(listener:EntityObserver) 
		{
			for (var i:int = 0; i < mListeners.length; i++)
			{
				if (mListeners[i].getId() == listener.getId()) {
					delete mListeners[i];
					return;
				}
			}
		}
		
		public function notify():void
		{
			var now:uint = FlxU.getTicks();
			
			var timeSinceLast = now - mLastTime;
			
			if (timeSinceLast >= mTimeBetweenNotifications)
			{
				for (var i:int = 0; i < mListeners.length; i++)
				{	
					mListeners[i].onNotify();
				}
				
				mLastTime = FlxU.getTicks();
			}
		}
		
		public function setNotificationCooldown(milliseconds:uint):void {
			mTimeBetweenNotifications = milliseconds;
		}
		
		public function isReady():Boolean
		{
			return mTimeBetweenNotifications <= FlxU.getTicks() - mLastTime;
		}
	}

}