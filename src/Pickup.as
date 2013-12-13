package  
{
	import flash.automation.Configuration;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	import PlayerCharacter;
	import PlayState;
	import org.flixel.*;
	
	public class Pickup extends GameObject 
	{
		public var mGame:PlayState;
		var mDefaultFrames:Array;
		public var Local:Boolean;
		var mPickupName:String;
		var mType:String;
		
		public static const ITEM_KEY:String = "KEY";
		public function Pickup(game:PlayState,name:String, type:String ,pos:Point, local:Boolean) 
		{
			super(pos.x, pos.y, null);
			loadGraphic(GameResources.Pickups, true, false, 16, 16, false);
			mDefaultFrames = [0];
			mGame = game;
			visible = false;
			active = false;
			Local = local;
			mPickupName = name;
			mType = type;
		}
		
		public function IsOfType(type:String):Boolean
		{
			return mType == type;
		}
		public function Activate():void
		{
			visible = true;
			active = true;
		}
		
		public function PickupName():String
		{
			return mPickupName;
		}
		
		override public function Init():void
		{
			addAnimation("default", mDefaultFrames, 40, true);
		}
		
		override public function update():void
		{
			super.update();
			FlxG.collide(this, mGame.ActivePlayer(), Pickup.OnHitPickup);
		}
		
		public static function OnHitPickup(obj1:Pickup, obj2:GameObject):void
		{
			trace("WHOOHOO");
			obj1.mGame.AddItemToPlayer(obj1);
		}
		
	}

}