package  
{
	import flash.display.TriangleCulling;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.flixel.FlxText;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	import org.flixel.system.FlxTile;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	
	public class LevelMap extends FlxTilemap
	{
	
		protected var mCollisionIndex:int;
		public var mCollisionMap:FlxTilemap;
		
		public var TILE_WIDTH:uint = 32;
		public var TILE_HEIGHT:uint = 32;
		public var CollisionmapLoaded:Boolean;
		
		var mLayers:Array;
		
		var mytile:ScrollingTile;
		
		//Test
		var testIndex:int = 0;
		
		public function LevelMap(game:PlayState) 
		{
			super();
			TILE_WIDTH = game.getTileWidth();
			TILE_HEIGHT = game.getTileHeight();
			
			mCollisionIndex = 2;
			mCollisionMap = new FlxTilemap();
			CollisionmapLoaded = false;
			mLayers = new Array();
		}
		
		public function AddLayer(tiledata:String):void
		{
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.loadMap(tiledata, GameResources.Map_Tile_2, TILE_WIDTH, TILE_HEIGHT);
				
			mLayers.push(tilemap);
		}
		
		public function AddLayersToStage(game:PlayState)
		{
			for (var i:int = 0; i < mLayers.length; i++)
			{
				if (i == 3)
					game.LAYER_BKG.add(mLayers[i]);
				else if (i == 2)
					game.LAYER_BKG.add(mLayers[i]);
				else if (i == 1)
					game.LAYER_BKG1.add(mLayers[i]);
				else if (i == 0)
				{
					var map:FlxTilemap =  mLayers[i];
					game.LAYER_FRONT.add(mLayers[i]);
				}
					
					
			}
		}
		
		public function updateLayers()
		{
			var map:FlxTilemap = mLayers[0];
		}
		
		public function RemoveLayersFromStage(game:PlayState)
		{
			
		}
		
		public function SetCollisionIndex(i:int):void
		{
			mCollisionIndex = i;
		}
		
		public function CreateSimpleLevel():void
		{
			var data:Array = new Array(1, 1, 1, 0, 0, 0, 1, 1, 1);
			loadMap(FlxTilemap.arrayToCSV(data,3,false), GameResources.Tiles_Base, 16, 16, 0, 0, 1, mCollisionIndex);
		}
		
		public function LoadCollision(data:String, collisionindex:uint = 1):void
		{
			mCollisionMap.loadMap(data, GameResources.Map_Tile_2, TILE_WIDTH, TILE_HEIGHT, 0, 0, 0, collisionindex);
			CollisionmapLoaded = true;
		}
		
		public function LoadLevel(data:String, collisionIndex:uint =0):void 
		{
			loadMap(data, GameResources.Map_Tile_2, TILE_WIDTH, TILE_HEIGHT, 0, 0, 0, collisionIndex);
		}
		
		override public function loadMap(MapData:String, TileGraphic:Class, TileWidth:uint = 0, TileHeight:uint = 0, AutoTile:uint = OFF, StartingIndex:uint = 0, DrawIndex:uint = 1, CollideIndex:uint = 1):FlxTilemap 
		{
			auto = AutoTile;
			_startingIndex = StartingIndex;

			//Figure out the map dimensions based on the data string
			var columns:Array;
			var rows:Array = MapData.split("\n");
			heightInTiles = rows.length;
			_data = new Array();
			var row:uint = 0;
			var column:uint;
			while(row < heightInTiles)
			{
				columns = rows[row++].split(",");
				if(columns.length <= 1)
				{
					heightInTiles = heightInTiles - 1;
					continue;
				}
				if(widthInTiles == 0)
					widthInTiles = columns.length;
				column = 0;
				while(column < widthInTiles)
					_data.push(uint(columns[column++]));
			}
			
			//Pre-process the map data if it's auto-tiled
			var i:uint;
			totalTiles = widthInTiles*heightInTiles;
			if(auto > OFF)
			{
				_startingIndex = 1;
				DrawIndex = 1;
				CollideIndex = 1;
				i = 0;
				while(i < totalTiles)
					autoTile(i++);
			}
			
			//Figure out the size of the tiles
			_tiles = FlxG.addBitmap(TileGraphic);
			_tileWidth = TileWidth;
			if(_tileWidth == 0)
				_tileWidth = _tiles.height;
			_tileHeight = TileHeight;
			if(_tileHeight == 0)
				_tileHeight = _tileWidth;
			
			//create some tile objects that we'll use for overlap checks (one for each tile)
			i = 0;
			var l:uint = (_tiles.width/_tileWidth) * (_tiles.height/_tileHeight);
			if(auto > OFF)
				l++;
			_tileObjects = new Array(l);
			var ac:uint;
			while(i < l)
			{
				_tileObjects[i] = new FlxTile(this,i,_tileWidth,_tileHeight,(i >= DrawIndex),(i >= CollideIndex)?allowCollisions:NONE);
				i++;
			}
			
			//create debug tiles for rendering bounding boxes on demand
			_debugTileNotSolid = makeDebugTile(FlxG.BLUE);
			_debugTilePartial = makeDebugTile(FlxG.PINK);
			_debugTileSolid = makeDebugTile(FlxG.GREEN);
			_debugRect = new Rectangle(0,0,_tileWidth,_tileHeight);
			
			//Then go through and create the actual map
			width = widthInTiles*_tileWidth;
			height = heightInTiles*_tileHeight;
			_rects = new Array(totalTiles);
			i = 0;
			while(i < totalTiles)
				updateTile(i++);

			return this;
		}
		
		override public function draw():void 
		{
			var d:int = 3;
			
			//for (var i:int = 0; i < mLayers.length; i++)
			/*for (var i:int = mLayers.length-1; i >= 0; i--)
			{
				mLayers[i].draw();
			}
			//if (FlxG.keys.pressed("R")
			
			
			//mLayers[testIndex].draw();
			*/
			
			//mLayers[0].draw();
			var j:int = 0;
			//super.draw();
		}
		
		public function OnCompleteLoad(e:Event)
		{
			trace("DONE");
		}
		
		public function GetRandomFloorTile():FlxTileblock
		{
			var t:FlxTileblock = null;
			var found:Boolean = false;
			var tries:uint = 0;
			var max_tries:uint = 250;
			
			//var index_x:uint = 0;
			//var index_y:uint = 0;
				
			while (!found)
			{
				tries++;
				if (tries >= max_tries)
					found = true;
					
				var index_x:uint = Math.random() * 16;
				var index_y:uint = Math.random() * 15;
				
				if (mCollisionMap.getTile(index_x, index_y) != mCollisionIndex)
				{
					t = new FlxTileblock(index_x, index_y, 16, 16);
					found = true;
				}
			}
			
			return t;
		}
		
	}

}