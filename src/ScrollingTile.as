package 
{
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class ScrollingTile extends FlxTile
	{
		public function ScrollingTile(map:FlxTilemap, index:int, w:int,h:int)
		{
			super(map, index, w, h, true, 0);
		}
		
		override public function draw():void 
		{
			super.draw();
		}
	}
	
}