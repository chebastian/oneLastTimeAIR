package Tests 
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class DynamicLevelLoaderTest 
	{
		var mGame:PlayState;
		var mLastDate:Date;
		var lastCheck:Number;
		public function DynamicLevelLoaderTest(game:PlayState) 
		{
			mGame = game;
			mLastDate = null;
			
			var d:Date = new Date();
			lastCheck = d.getTime();
		}
		
		public function startTest():void
		{
			var d:Date = new Date();
			if (d.getTime() - lastCheck > 500)
			{
				lastCheck = d.getTime();
				trace("CKECKING");
				trace(lastCheck);
			}
			else
				return;
				
			var lastDate:Date = mLastDate;
			var f:File = File.applicationDirectory.resolvePath(mGame.ActiveLevel().getLevelPath());
			if (f.exists && !f.isDirectory)
			{
				mLastDate = f.modificationDate;
				
				if (lastDate != null)
				{
					if (mLastDate.getTime() != lastDate.getTime())
					{
						mGame.ActiveLevel().testreloadLevel();
					}
				}
			}
		}
		
	}

}