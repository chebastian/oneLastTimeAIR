package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class SwitchObserver extends EntityObserver 
	{
		protected var mWall:WallSwitch;
		protected var mWalls:FlxGroup;
		
		public function SwitchObserver(wallSwitch:FlxGroup) 
		{
			mWalls = wallSwitch;
		}
		
		public function SwitchObserver(wall:WallSwitch) {
			mWall = wall;
		}
		
		override public function onNotify():void 
		{
			for each(var wall:WallSwitch in mWalls)
			{
				wall.setOpen(!wall.isOpen());
			}
		}
		
	}

}