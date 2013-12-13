package  
{
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class LevelListEntry
	{
		var mName:String;
		var mPath:String;
		var mText:FlxText;
		public function LevelListEntry(name:String, path:String) 
		{
			mName = name;
			mPath = path;
			mText = getText();
		}
		
		public function getText():FlxText
		{
			return new FlxText(0, 0, 100, mName);
		}
		
		public function getPathToXML():String
		{
			var xmlEnd:String = ".xml";
			var folderStart:String = "\\";
			var levelsFolder:String = "./media/levels/" + mName;
			var xmlPath:String = levelsFolder + "/" + mName + xmlEnd;
			
			return xmlPath;
		}
		
		public function Name():String
		{
			return mName;
		}
		
		public function Path():String
		{
			return mPath;
		}
		
		public function setSelected():void
		{
			//mName = mName.toUpperCase();
			var selection:String = "___";
			mText.text = selection + mName + selection;
		}
		
		public function setUnselected():void {
			//mName = mName.toLocaleLowerCase();
			mText.text = mName;
		}
		
	}

}