package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxU;
	import RoomAssets.RaisableWall;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class WallNotifier extends EntityNotifier
	{
		var mWalls:FlxGroup;
		var mGame:PlayState;
		
		public function WallNotifier(game:PlayState, walls:FlxGroup) 
		{
			super();
			mWalls = walls;
			mGame = game;
			mTimeBetweenNotifications = 500;
		}
		
		override public function notify():void
		{
			var now:uint = FlxU.getTicks();
			
			var timeSinceLast = now - mLastTime;
			
			if (timeSinceLast >= mTimeBetweenNotifications)
			{
				mGame.ActiveLevel().setGlobalSwitchState(!mGame.ActiveLevel().getGlobalSwitchState());
				for each(var wall:RaisableWall in mWalls.members)
				{
					//mGame.ActiveLevel().setGlobalSwitchState(wall.toggleOpenClosed());
					wall.toggleOpenClosed();
				}
			}
			super.notify();
		}
		
	}

}