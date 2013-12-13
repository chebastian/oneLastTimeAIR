package  
{
	import AttackReactions.DamageReaction;
	import CharacterController.InputController;
	import CharacterStates.AttackState;
	import CharacterStates.DeathState;
	import CharacterStates.PlayerDeathState;
	import flash.accessibility.AccessibilityImplementation;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.NetGroupReplicationStrategy;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.flixel.system.input.Input;
	import PlayerCharacter;
	import org.flixel.*;
	import com.adobe.serialization.json.JSON;
	import flash.display.LoaderInfo;

	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PirateCharacter extends PlayerCharacter 
	{
		var mWeaponReach:Number;
		var mLoader:ExternalBitmap;
		var mWalkAnim:FlxSprite;
		var mShadow:FlxSprite;
		//var animLoader:AnimationLoader;
		public function PirateCharacter(game:PlayState, pos:Point) 
		{
			super(game, pos);
		}		
		
		override public function Init():void 
		{
			super.Init();
			mHitBox = new GameObject(this.x, this.y, null);
			srcWH = new Point(8, 12);
			
			SetSpeed(25);
			scale.x = 1;
			scale.y = 1;
			//mAABBOffset = new Point(-10, 6);
			var hOffset:int = 6;
			mAABBOffset = new Point(1, hOffset);
			mAABBHeightOffset = -hOffset;
			mAABBWidthOffset = -2;
			mBulletOriginOffset.x = 0;
			mBulletOriginOffset.y = 0;
			//mAABBHeightOffset = 12;
			//mAABBWidthOffset = 15;
			
			mHitBoxSizeOffset = new Point(-2, -2);
			mHitBoxPosOffset = new Point(1, 0);
			mHitBox.width = width * this.scale.y;
			mHitBox.height= this.height * this.scale.y;
			
			mWeaponReach = 5;
			mWeaponHitbox = new GameObject(this.x, this.y, null);
			mWeaponHitbox.width = 3;
			mWeaponHitbox.height = 3;
			mAnimationFrameRate = 2;
			mAnimationsPath = "./media/player/player_anim.txt";
			mShadow = new FlxSprite(x, y, mGame.getResources().getResource("playerShadow"));
			mReactions.pushReaction(new DamageReaction(this, 100));
			
			mController = new InputController(this, mGame);
		}
		
		public override function onAnimationLoadComplete(e:Event):void 
		{
			mAnimations = animLoader.getAnimationBank();
			mAnimations.registerAnimationsToSprite(this);
			ChangeAnimation(Animation_WalkDown);
		}
		
		override public function update():void 
		{
			super.update();
				
			if (mHealth < 0)
				ChangeState(new PlayerDeathState(this));
			this.mWeaponHitbox.x = this.x + (mHeading.x * this.mWeaponReach);
			this.mWeaponHitbox.y = this.y + (mHeading.y * this.mWeaponReach);
		}
		
		override public function UpdateHitbox():void 
		{
			super.UpdateHitbox();
		}
		
		public function updateShadow():void
		{
			mShadow.x = this.x;
			mShadow.y = this.y;
		}
		override public function draw():void 
		{
			updateShadow();
			mShadow.draw();
			super.draw();
			//this.mWeaponHitbox.draw();
			//drawDebug(null);
		}
		
		public function HandleInput():void 
		{
			var speed:Number = WALK_SPEED;
		
				
			if (IsInState(CharacterState.ATTACK_STATE) || IsInState(CharacterState.DAMAGED_STATE) )
				return;
				
			if (FlxG.keys.justPressed("A")) 
			{
				ChangeState(new AttackState(this));
			}
				
			else if (FlxG.keys.pressed("LEFT"))
			{
				Move(new Point( -1, 0), speed);
				ChangeAnimation(this.Animation_WalkLeft);
			}
			
			else if (FlxG.keys.pressed("RIGHT"))
			{
				Move(new Point( 1, 0), speed);
				ChangeAnimation(this.Animation_WalkRight);
				this.facing = RIGHT;
			}
			else if (FlxG.keys.pressed("UP"))
			{
				Move(new Point( 0, -1), speed);
				ChangeAnimation(this.Animation_WalkUp);
			}
			else if (FlxG.keys.pressed("DOWN"))
			{
				Move(new Point( 0, 1), speed);
				ChangeAnimation(this.Animation_WalkDown);
			}
			else
			{
				//ChangeAnimation(Character.Animation_Idle);
				this.play(mCurrentAnimation, true);
				StopMoving();
			}
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				var factory:BulletFactory = new BulletFactory(mGame);
				//mGame.getBulletMgr().addBullet(factory.createRayFromCharacter(this, 5, 50)); 
				mGame.getBulletMgr().addBullet(factory.createBulletFromCharacter(this, 0.2, 50));
			}
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			if (mHitBox.overlaps(char) && char.Attacking())
			{
				mReactions.getReaction().onAttacked(char);
				return true;
			}
			
			return false;
			//return super.OnHitCharacter(char);
		}
		
	}

}