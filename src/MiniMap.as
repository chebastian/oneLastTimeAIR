package  
{
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 * @desc MiniMap: Takes a levelCell as argument and creates a tiled minimap 
	 * which is rendered at specified destination
	 * current location in level is marked with yellow outline
	 */
	public class MiniMap extends GameObject 
	{
		var mLevel:CellLevel;
		var mTilesArray:FlxGroup;
		var mActiveIndex:Point;
		
		public function MiniMap(level:CellLevel,_x:Number, _y:Number) 
		{
			super(_x, _y, null);
			mLevel = level;
			width = mLevel.width;
			height = mLevel.height;
			mTilesArray = new FlxGroup(width * height);
			mActiveIndex = new Point();
			scrollFactor.x = 0;
			scrollFactor.y = 0;
		}
		
		public function GenerateMap():void
		{
			var cellW:uint = 8;
			var cellH:uint = 4;
			for (var i:uint = 0; i < width; i++)
			{
				for (var j:uint = 0; j < height; j++)
				{
					var newx:uint = x + (cellW * i);
					var newy:uint = y + (cellH * j);
					
					var mapTile:GameObject = new GameObject(newx, newy, GameResources.Map_Tile);
					mapTile.loadGraphic(GameResources.Map_Tile, false, false, 8, 4, false);
					mapTile.addAnimation("active", [1], 0, false);
					mapTile.addAnimation("inactive", [0], 0, false);
					
					if (mLevel.IsActiveRoom(new Point(i, j)))
					{
						mapTile.play("active");
					}
					
					if (!mLevel.RoomExistsAt(new Point(i, j)))
					{
						//mapTile.visible = false;
					}
					mLevel.mGame.LAYER_FRONT.add(mapTile);
					mTilesArray.add(mapTile);
					mapTile.scrollFactor.x = 0;
					mapTile.scrollFactor.y = 0;
				}
			}
		}
		
		public function SetActiveTile(pos:Point):void
		{
			SetInactiveTile(mActiveIndex);
			var tile:GameObject = mTilesArray.members[pos.y + pos.x * width];
			
			if (tile != null)
			{
				tile.play("active");
			}
			mActiveIndex = pos;
		}
		
		public function SetInactiveTile(pos:Point):void
		{
			var tile:GameObject = mTilesArray.members[pos.y + pos.x * width];
			
			if (tile != null)
			{
				tile.play("inactive");
			}
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}