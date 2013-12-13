package  RoomAssets
{
	import adobe.utils.CustomActions;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class RaisableWall extends GameObject 
	{
		protected var mIsOpen:Boolean;
		protected var mGame:PlayState;
		
		public function RaisableWall(game:PlayState,_x:Number, _y:Number) 
		{
			super(_x, _y, null);
			mGame = game;
			loadGraphic(GameResources.RaisableWall, true, false, 7, 7, false);
			Init();
			mIsOpen = true;
			
			this.velocity.x = 0;
			this.velocity.y = 0;
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
			this.moves = false;
			this.immovable = true;
			solid = !mIsOpen;
		}
		
		override public function Init():void 
		{
			addAnimation("open", [0], 0, false);
			addAnimation("closed", [1], 0, false);
			play("open", true);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		
		public virtual function setOpen(isOpen:Boolean):void
		{
			mIsOpen = isOpen;
			solid = !mIsOpen;
			changeAnimationState(mIsOpen);
			
			
			
			if (this.overlaps(mGame.ActivePlayer()) && !mIsOpen)
			{
				mGame.ActivePlayer().killPlayer();
			}
		}
		
		protected virtual function changeAnimationState(open:Boolean):void
		{
			if (open)
				play("open", true);
			else
				play("closed", true);
		}
		
		public function toggleOpenClosed():Boolean
		{
			setOpen(!mIsOpen);
			changeAnimationState(mIsOpen);
			
			
			return mIsOpen;
		}
		
	}

}