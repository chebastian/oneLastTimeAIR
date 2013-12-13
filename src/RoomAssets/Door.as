package  RoomAssets
{
	import org.flixel.FlxCamera;
	import flash.automation.ActionGenerator;
	import flash.geom.Point;
	import org.flixel.FlxBasic;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	import org.flixel.FlxG;
	
	public class Door extends GameObject 
	{	
		var mGame:PlayState;
		var mLocked:Boolean;
		var mLockId:String;
		
		public function Door(game:PlayState ,id:String, pos:Point ,locked:Boolean) 
		{
			super(pos.x * game.getTileWidth(), pos.y * game.getTileHeight(),null);
			mGame = game;
			loadGraphic(GameResources.Tile_Locked, false, false, 32, 32, false);
			mGame.LAYER_ITEM.add(this);

			this.immovable = true;
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(this, mGame.ActivePlayer(),Door.OnHitPlayer);
		}
		
		public static function OnHitPlayer(door:Door, player:PlayerCharacter):void
		{
			if (player.HasKeys())
			{
				player.UseKey();
				door.Unlock();
			}
		}
		
		public function Unlock():void
		{
			kill();
		}
		
		public function IsLocked():Boolean
		{
			return mLocked;
		}
		
	}

}