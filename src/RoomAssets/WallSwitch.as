package  RoomAssets
{
	import AttackReactions.SwitchReaction;
	import CharacterStates.DeathState;
	import CharacterStates.SleepState;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class WallSwitch extends Character
	{
		
		protected var mIsOpen:Boolean;
		//protected var mNotifier:WallNotifier;
		protected var mCoolDown:Number;
		protected var mLastSwitch:Number;
		protected var mLastHitTime:Number;
		protected var mMinHitDiff:Number = 0.3;
		
		public function WallSwitch(game:PlayState, _x:Number, _y:Number) 
		{
			super(game,_x, _y);
			Init();
			immovable = true;
			solid = true;
			mReactions.setReaction(new SwitchReaction(this));
		}
		
		override public function Init():void 
		{
			super.Init();
			mAABBHeightOffset = 0;
			mAABBWidthOffset = 0;
			mAABBOffset = new Point(0, 0);
			srcWH = new Point(8, 8);
			width = 8;
			height = 8;
			mCoolDown = new Number(0.5);
			mLastSwitch = mCoolDown;
			mAnimationsPath = "./media/wallSwitch/switch_anims.txt";
			InitAnimations();
		}
		
		override public function InitAnimations():void 
		{
			super.InitAnimations();
			//loadGraphic(GameResources.WallSwitch, true, false, 8, 8, false);
			//addAnimation("open", [0,1,2,3],10,false);
			//addAnimation("closed", [4,5,6,7], 10, false);
			//play("open");
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			setOpenAnimation(mIsOpen);
		}
		
		override public function update():void 
		{
			super.update();
			
			mLastSwitch += FlxG.elapsed;
		}
		
		override public function ChangeAnimation(name:String, img:Class = null,force:Boolean = false):void 
		{
			super.ChangeAnimation(name, img,force);
		}
		
		public function setOpenAnimation(status:Boolean):void {
			if (status)
				ChangeAnimation("open",null,true);
			else
				ChangeAnimation("closed",null,true);
		}
		
		public function addNotifier(notifier:WallNotifier):void {
			mNotifier = notifier;
		}
		
		public function toggleOpen():Boolean 
		{
			if (!mNotifier.isReady())
				return mIsOpen;
				
			setOpen(!mIsOpen);
			
			mNotifier.notify();
			mGame.ActiveLevel().setGlobalSwitchState(mIsOpen);
			
			return mIsOpen;
		}
		public function setOpen(status:Boolean) {
			
			mIsOpen = status;
			setOpenAnimation(mIsOpen);
		}
		
		public function isOpen():Boolean {
			return mIsOpen;
		}
		
		public function onHit(obj:GameObject) 
		{
			if (obj.overlaps(this))
			{
				mReactions.getReaction().onAttacked(this);
			}
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			if (char.overlaps(this))
			{
				mReactions.getReaction().onAttacked(char);
				return true;
			}
			
			return false;
		}
		
	}

}