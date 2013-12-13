package  
{
	import flash.filesystem.File;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class LevelList 
	{
		var levels:Array;
		var mCurrentSelection:uint;
		public function LevelList() 
		{
			mCurrentSelection = 0;
		}
		
		public function loadLevelList(path:String):Array
		{
			levels = new Array();
			var levelFolder:File = File.applicationDirectory.resolvePath(path);
			
			if (levelFolder.exists && levelFolder.isDirectory)
			{
				addFoldersToList(levelFolder);
			}
			
			return levels;
		}
		
		protected function addFoldersToList(folder:File):void
		{
			var fileArr = folder.getDirectoryListing();
			for each(var file:File in fileArr)				
			{
				if (file.isDirectory)
				{
					levels.push(new LevelListEntry(file.name,file.nativePath));
				}
			}
		}
		
		public function getItemInList(i:uint):LevelListEntry
		{
			if (i < levels.length)
				return levels[i];
				
			if (i < 0)
				return levels[0];
			if (i >= levels.length)
				return levels[levels.length-1];
				
			return new LevelListEntry("null","null");
		}
		
		public function setSelected(i:uint):LevelListEntry
		{
			getItemInList(mCurrentSelection).setUnselected();
			mCurrentSelection = i;
			getItemInList(i).setSelected();
			return getItemInList(i);
		}
		
		public function getSelected():LevelListEntry
		{
			return getItemInList(mCurrentSelection);
		}
		
		public function moveSelectionUp():LevelListEntry
		{
			var i:uint = mCurrentSelection.valueOf();
			i++;
			return setSelected(i);
		}
		
		public function moveSelectionDown():LevelListEntry
		{
			var i:uint = mCurrentSelection.valueOf();
			if(i -1 >= 0)
				i--;
			return setSelected(i);
		}
		
	}

}