package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	
	 import com.adobe.protocols.dict.events.MatchStrategiesEvent;
	 import flash.filesystem.File;
	 
	public class FolderScanTest 
	{
		public function FolderScanTest() 
		{
		}
		
		public function intitTest():void {
			getFilesInFolder();
		}
		
		protected function getFilesInFolder():Array
		{
			var mediaFolder:File = File.applicationDirectory.resolvePath("./media/levels");
			var str:String = mediaFolder.url;
			
			if (mediaFolder.exists && mediaFolder.isDirectory)
			{
				var list:Array = mediaFolder.getDirectoryListing();
				for each( var entry:File in list )
				{
					trace(entry.nativePath);
					trace(entry.name);
				}
			}
			
			return null;
		}
		
	}

}