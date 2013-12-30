package  
{
	import CharacterStates.BulletExplodeState;
	import CharacterStates.BulletTravelState;
	import org.flixel.FlxCamera;
	import adobe.utils.CustomActions;
	import CharacterStates.IdleState;
	import com.adobe.air.crypto.EncryptionKeyGenerator;
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxBasic;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Bullet extends Character 
	{
		var mAnimLoader:AnimationLoader;
		public var LifeTime:Number;
		var TimeSinceCreation:Number;
		public var Owner:int;
		protected var VelDir:Point;
		protected var Killed:Boolean;
		protected var mFireSound:String;
		protected var mMaxDist:Number
		
		public function Bullet(game:PlayState, _x:Number, _y:Number,dir:Point) 
		{
			super(game, _x, _y);
			mHeading = dir;
			TimeSinceCreation = 0.0;
			LifeTime = 5.0;
			Owner = 0;
			Killed = false;
			active = true;
			VelDir = new Point(dir.x, dir.y);
			VelDir.normalize(1.0);
			height = 5;
			width = 5;
			mAABBOffset = new Point(0, 0);
			mAABBWidthOffset = 0;
			mAABBHeightOffset = 0;
			mBulletOriginOffset = new Point(0, 0);
			srcWH = new Point(0, 0);
			mIsAttacking = true;
			mAnimationsPath = "./media/player/bullet/bullet_anims.txt";
			mFireSound = "bullet_shoot";
			mMaxDist = 0;
		}
		
		override public function Init():void 
		{
			//mState = new BulletTravelState(this);
			ChangeState(new BulletTravelState(this));
			mIsAttacking = true;
			mWeaponHitbox = new GameObject(x, y, null);
			mHitBox = new GameObject(x, y, null);
			mHitBoxPosOffset = new Point(0, 0);
			mHitBoxSizeOffset = new Point(0, 0);
			mAABBWidthOffset = -1;
			mAABBHeightOffset = -1;
			mAABBOffset = new Point(1, 1);
			mSpawnPoint = new Point(x, y);
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			ChangeAnimation("fire");
		}
		
		override public function update():void 
		{
			if (!isReadyToDisplay())
				return;
				
			if (active && exists)
			{
				UpdateHitbox();
				updateLookAt();

				mState.OnUpdate();
			}
		}
		
		override public function draw():void 
		{
			if(isReadyToDisplay())
				super.draw();
		}
		
		public virtual function updatePosition():void
		{
			Move(VelDir, Speed());
		}
		
		public virtual function updateLifeTime():void
		{
			TimeSinceCreation += FlxG.elapsed;
		}
		
		public virtual function isTimeToDie():Boolean
		{
			var deathByLength:Boolean = false;
			deathByLength = ((mMaxDist > 0) && (travelDist() > mMaxDist));
			
			if (mMaxDist > 0)
				return deathByLength || Killed;
			
			return (TimeSinceCreation >= LifeTime) || Killed;
		}
		
		public function travelDist():Number
		{
			var d:Point = new Point(x.valueOf() - mSpawnPoint.x, y.valueOf() - mSpawnPoint.y);
			return d.length;

		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			super.OnHitCharacter(char);
			if (!IsInState(BulletExplodeState.STATE_ID) && overlaps(char))
			{
				ChangeState(new BulletExplodeState(this));
				return true;
			}
				
			return false;
		}
		
		public function killBullet():void
		{
			Killed = true;
		}
		
		public function setDir(dir:Point):void
		{
			mHeading = dir;
			VelDir = dir;
		}
		
		public function getFireSoundEffect():String
		{
			return mFireSound;
		}
		
		public function getMaxDist():Number
		{
			return mMaxDist;
		}
		
		public function setMaxDist(d:Number):void
		{
			mMaxDist = d.valueOf();
		}
		
		public function clone():Bullet
		{
			var b:Bullet = new Bullet(mGame, this.x, this.y,VelDir.clone());
			b.setAnimationSrc(mAnimationsPath);
			b.setHeading(mHeading.clone());
			b.setDir(VelDir.clone());
			b.SetSpeed(Speed());
			b.mStrength = mStrength;
			
			return b;
		}
		
		
	}

}