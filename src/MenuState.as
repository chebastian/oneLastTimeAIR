package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import Main;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class MenuState extends FlxState
	{
		var state:FlxState;
		var mLevels:Array;
		var mLevelList:LevelList;
		public function MenuState() 
		{
			super();
			mLevelList = new LevelList();
			mLevels = mLevelList.loadLevelList("./media/levels");
			//add(new FlxText(10, 3, FlxG.height*0.2, "..ONE LAST TIME.."));
			//add(new FlxText(10, 48, FlxG.height * 0.2, "Press SPACE to Continue"));
			//add(new FlxText(10, 14, 100, "Arrows to move, Space to shoot"));;
			//FlxG.switchState(new PlayState());
			printLevelNames();
		}
		
		public function printLevelNames():void 
		{
			var h:Number = 10;
			for (var i:uint = 0; i < mLevels.length; i++)
			{
				var lvl:LevelListEntry = mLevels[i];
				var test:FlxText = lvl.mText;
				test.y = i * h;
				h = test.height;
				add(test);
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.pressed( "SPACE" ))
			{
				state = new PlayState(mLevelList.getSelected().getPathToXML());
				FlxG.switchState(state);
			}
			
			handleLevelSelection();
		}
		
		override public function draw():void 
		{
			super.draw();
		}
		
		private function handleLevelSelection():void
		{
			if (FlxG.keys.justPressed("DOWN"))
			{
				mLevelList.moveSelectionUp();
			}
			
			if (FlxG.keys.justPressed("UP"))
			{
				mLevelList.moveSelectionDown();
			}
		}
		
	}

}