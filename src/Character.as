package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	
	 import adobe.utils.ProductManager;
	 import AttackReactions.ReactionManager;
	 import CharacterController.CharacterController;
	 import CharacterStates.IdleState;
	 import CharacterStates.StateManager;
	 import CharacterStates.WanderState;
	 import flash.display.ShaderParameter;
	 import flash.events.Event;
	 import flash.events.ProgressEvent;
	 import flash.geom.Point;
	 import flash.net.URLLoader;
	 import flash.net.URLRequest;
	 import flash.printing.PrintJobOrientation;
	 import GameObject;
	 import CharacterController.*;
	 import org.flixel.FlxPoint;
	 import org.flixel.FlxRect;
	 
	public class Character extends GameObject
	{
		
		public var Animation_Idle:String = "idle";
		public var Animation_WalkLeft:String = "walkLeft";
		public var Animation_WalkRight:String = "walkRight";
		public var Animation_WalkUp:String = "walkUp";
		public var Animation_WalkDown:String = "walkDown";
		
		public var Animation_Attack_R:String = "attackR";
		public var Animation_Attack_L:String = "attackL";
		public var Animation_Attack_D:String = "attackD";
		public var Animation_Attack_U:String = "attackU";
		public var Animation_DamagedR:String = "damagedR";
		public var Animation_DamagedL:String = "damagedL";
		public var Animation_DamagedU:String = "damagedU";
		public var Animation_DamagedD:String = "damagedD";
		
		public var Animation_Jump:String = "jump";
		
		var mCurrentAnimation:String;
		
		var WALK_SPEED:uint = 150;
		public var mGame:PlayState;
		var mWandering:Boolean;
		protected var mHeading:Point;
		protected var mIsAttacking:Boolean;
		protected var mLookAt:Point;
		
		protected var mState:CharacterState;
		protected var mStateMgr:StateManager;
		
		var mAnimationFrameRate:uint;
		
		var mHitCharCooldown:Number;
		var mStrength:Number;
		var mHealth:Number;
		var mArmorClass:Number;
		
		var mWeaponHitbox:GameObject;
		protected var mHitBox:GameObject;
		
		var mHitBoxPosOffset:Point;
		var mHitBoxSizeOffset:Point;
		protected var srcWH:Point;
		protected var mSpawnPoint:Point;
		
		/*Loader for JSON*/
		var mLoaderJSON:URLLoader;
		
		/*TEMP FOR ATTACKING*/
		protected var animLoader:AnimationLoader;
		var mAnimations:AnimationBank;
		protected var mAnimationsPath:String;
		var mCurrentImg:Class;
		
		/*Character controllers*/
		var mController:CharacterController;
		var mMovementBounds:FlxRect;
		var mShadowOffset:Point;
		
		
		/*Char attackreacktion*/
		protected var mReactions:ReactionManager;
		protected var mBulletOriginOffset;
		protected var mTargetPosition:Point;
		protected var mCurrentWeapon:Weapon;
		
		
		public function Character(game:PlayState, _x:Number, _y:Number) 
		{
			mGame = game;
			mCurrentAnimation = "";
			mHitBox = new GameObject(0, 0, null);
			mWeaponHitbox = new GameObject(0, 0, null);
			mHitBoxPosOffset = new Point(); 
			mBulletOriginOffset = new Point(0, 0);
			mHitBoxSizeOffset = new Point();
			
			//mAABBOffset = new Point(0, 10);
			//mAABBHeightOffset = -10;
			super(_x, _y, null);
			mAABBOffset = new Point(0, 0);
			mAABBHeightOffset = -0;
			mLookAt = new Point(0, 0);	
			maxVelocity.y = WALK_SPEED;
			maxVelocity.x = WALK_SPEED;
			mWandering = false;
			mHeading = new Point(0, 0);
			mIsAttacking = false;
			mAnimationFrameRate = 10;
			srcWH = new Point(0, 0);
			mAnimations = new AnimationBank();
			mReactions = new ReactionManager(this);
			mAnimationsPath = "";
			mController = new CharacterController(this, mGame);
			mMovementBounds = new FlxRect(0, 0, 0, 0);
			setTarget(new Point(0, 0));
			mShadowOffset = new Point(0, 0);
			mHealth = 100.0;
			mStateMgr = new StateManager();
			//Init();
		}
		
		override public function Init():void 
		{
			//InitAnimations();
			mState = new IdleState(0, this);
			mStrength = 1.0;
			mHealth = 100.0;
			mArmorClass = 1.0;
			mWeaponHitbox = new GameObject(x, y, null);
			mHitBox = new GameObject(x, y, null);
			mHitBoxPosOffset = new Point(0, 0);
			mHitBoxSizeOffset = new Point(0, 0);
			mCurrentWeapon = new Weapon(mGame, 1.0 / 3.0, 50, 0.5);
			mSpawnPoint = new Point(x, y);
		}
		
		public virtual function InitAnimations():void
		{
			/*loadGraphic(GameResources.Anim_LinkWalkDown, true, false, srcWH.x, srcWH.y, false);
			addAnimation(Animation_Idle,[0],mAnimationFrameRate);
			addAnimation(Animation_WalkLeft,[0,1,2,3,4,5,6],mAnimationFrameRate);
			addAnimation(Animation_WalkDown,[0,1,2,3,4,5,6,7],mAnimationFrameRate);
			addAnimation(Animation_WalkUp,[0,1,2,3,4,5,6,7],mAnimationFrameRate);
			addAnimation(Animation_WalkRight, [0, 1, 2, 3, 4, 5, 6], mAnimationFrameRate);
			
			
			ChangeAnimation(Animation_Idle, GameResources.Anim_LinkWalkDown);*/
			//var resources:GameResources = new GameResources();
			//resources.initResources();
			//loadGraphic(resources.getResource("Player_Sheet"), true, true, 16, 16, false);
			mCurrentAnimation = "";
			//srcWH = new Point(8, 12);
			animLoader = new AnimationLoader(mGame);
			
			animLoader.addEventListener(Event.COMPLETE, onAnimationLoadComplete);
			animLoader.loadBankFromFile(mAnimationsPath);
			//ChangeAnimation(Animation_WalkDown, resources.getResource("playerWalkDown"));
		}
		
		public virtual function onEnter():void
		{
			
		}
		
		public virtual function onAnimationLoadComplete(e:Event):void
		{
			mAnimations = animLoader.getAnimationBank();
			mAnimations.registerAnimationsToSprite(this);
		}
		
		public function loadAnimationFromJSON(path:String)
		{	
			mLoaderJSON = new URLLoader();
			mLoaderJSON.addEventListener(Event.COMPLETE, onLoadedAnimations);
			mLoaderJSON.load(new URLRequest(path));
		}
		
		public function onLoadedAnimations(e:Event):void 
		{
			
		}
		
		public function addClip(clip:AnimationClip)
		{
			mAnimations.addAnimation(clip);
			addAnimation(clip.name, clip.frames, clip.fps, clip.looped);
		}
		
		public function addAnimationClip(name:String, frames:Array, fps:Number, fw:Number, fh:Number, loop:Boolean,img:Class)
		{
			addAnimation(name, frames, fps, loop);
			var clip:AnimationClip = new AnimationClip(name, frames, fw, fh, img);
			clip.fps = fps;
			mAnimations.addAnimation(clip);
		}
		
		public function ChangeState(state:CharacterState)
		{
			/*if(mState != null)
				mState.OnExit();
			
			mState = null;
			mState = state;
			mState.OnEnter(mGame);*/
			if(mStateMgr.hasState())
				mStateMgr.getCurrentState().OnExit();
				
			mStateMgr.changeState(state);
			mStateMgr.getCurrentState().OnEnter(mGame);
		}
		
		public function PushState(state:CharacterState):void
		{
			mStateMgr.pushState(state);
			mStateMgr.getCurrentState().OnEnter(mGame);
		}
		
		public function PopState():void
		{
			mStateMgr.getCurrentState().OnExit();
			mStateMgr.popState();
		}
		
		public function IsInState(state:int):Boolean
		{
			var st:CharacterState = mStateMgr.getCurrentState();
			if (state == st.StateId())
			{
				return true;
			}
			
			return false;
		}
		
		override public function Move(dir:Point, dist:Number):void 
		{
			velocity.x = dir.x * dist;
			velocity.y = dir.y * dist;
			
			mHeading = dir;
			updateLookAt();
		}
		
		public function ChangeAnimationForced(name:String, img:Class = null):void
		{
			ChangeAnimation(name, img, true);
		}
		
		public function ChangeAnimation(name:String, img:Class = null,force:Boolean = false):void
		{
	
			if(IsPlayingAnimation(name) && !force)
				return;
				
			/*if (img != null)
			{
				loadGraphic(img,true,false,srcWH.x,srcWH.y);
				mCurrentImg = img;
			}*/
			
			if (mAnimations.containsClip(name))
			{
				revertAnimationTransformations();
				/*if (mAnimations.containsClip(mCurrentAnimation))
				{
					var current:AnimationClip = mAnimations.getAnimation(mCurrentAnimation);
					this.x -= current.origin.x;
					this.y -= current.origin.y;
				}*/
				
				var clip:AnimationClip = mAnimations.getAnimation(name);
				if (img != null)
					clip = mAnimations.getAnimationFromImg(img, name);
					
				if (clip.src != null)
					loadGraphic(clip.src, true , false, clip.fw, clip.fh, false);
					
				else if (clip.fh != srcWH.y || clip.fw != srcWH.x)
					loadGraphic(mCurrentImg, true, false, clip.fw, clip.fh, false);
					
				this.x += clip.origin.x;
				this.y += clip.origin.y;
				//	mCurrentAnimation = name;
				//play(name);
			}
			
			play(name);
			mCurrentAnimation = name;
		}
		
		
		public function revertAnimationTransformations():void
		{
			if (mAnimations.containsClip(mCurrentAnimation))
				{
					var current:AnimationClip = mAnimations.getAnimation(mCurrentAnimation);
					this.x -= current.origin.x;
					this.y -= current.origin.y;
				}
		}
		
		public function IsPlayingAnimation(name:String):Boolean
		{
			if (mCurrentAnimation.toLocaleLowerCase() == name.toLocaleLowerCase() ||
			name == "")
				return true;
			
			return false;
		}
		
		override public function update():void 
		{
			super.update();
			//mState.OnUpdate();
			if (mStateMgr.hasState())
				mStateMgr.getCurrentState().OnUpdate();
				
			mController.update();
			UpdateHitbox();
			updateLookAt();
		}
		
		public function UpdateHitbox():void 
		{
			//
			//Update players hitbox, used for receiving damage
			//
			mHitBox.x = x + mHitBoxPosOffset.x;
			mHitBox.y = y + mHitBoxPosOffset.y;
			mHitBox.width = (width*this.scale.x) + mHitBoxSizeOffset.x;
			mHitBox.height = (height*this.scale.y) + mHitBoxSizeOffset.y;
			
			//Update players attackHitBox, used for dealing damage
			//this box will be moved around depending on players heading
			var hitDist:Number = 0.0;
 			mWeaponHitbox.x = x + mHeading.x * hitDist;
			mWeaponHitbox.y = y + mHeading.y * hitDist;
			mWeaponHitbox.width = width;
			mWeaponHitbox.height = height;
		}
		
		protected function updateLookAt():void
		{
			mLookAt = mHeading;
		}
		
		public function TurnRight()
		{
			var xdir:Number = -mHeading.y;
			mHeading.y = mHeading.x;
			mHeading.x = xdir;
		}
		
		public function TurnInDir(dir:Point)
		{
			mHeading.x += dir.x;
			mHeading.y += dir.y;
			mHeading.normalize(1.0);
		}
		
		public function WalkInDir(dir:Point)
		{
			mHeading.x = dir.x;
			mHeading.y = dir.y;
			velocity.x = mHeading.x * WALK_SPEED;
			velocity.y = mHeading.y * WALK_SPEED;
		}
		
		public function Wander(dir:Point, speed:Number)
		{
			velocity.x = WALK_SPEED * dir.x;
			velocity.y = WALK_SPEED * dir.y;
			mHeading.x = dir.x;
			mHeading.y = dir.y;
			
			mWandering = true;
		}
		
		//
		// Called when character hits another character
		// ex: When player hits character, receive dmg or do dmg depending on state
		//
		public function OnHitCharacter(char:Character):Boolean
		{
			if (char.Attacking())
			{
				mReactions.getReaction().onAttacked(char);
				return true;
			}
			
			return false;
			
		}
		
		public function HeadForCharacter(char:Character):void 
		{
				var dir:Point = new Point(char.x - x, char.y - y);
				var len:Number = dir.length;
				dir.normalize(1);
				mHeading = dir;
		}
		
		public function IsFacingCharacter(char:Character):Boolean
		{
			var dir:Point = new Point(x, y);
			dir.x = x - char.x;
			dir.y = y - char.y;
			dir.normalize(1.0);
			
			areFacingEachother(char);
			
			if (dir.x < 0 && mHeading.x > 0)
				return true;
			else if (dir.x > 0 && mHeading.x < 0)
				return true;
			else if (dir.y < 0 && mHeading.y > 0)
				return true;
			else if (dir.y > 0 && mHeading.y < 0)
				return true;
			
			return false;
		}
		
		public function areFacingEachother(char:Character):Boolean
		{
			var toChar:Point = new Point(x - char.x, y -char.y);
			toChar.normalize(1.0);
			
			var dot:Number = (getLookAt().x * toChar.x) + (getLookAt().y * toChar.y);
			if (dot < 0.0)
				return true;
			
			return false;
		}
		
		
		 
		 public function canSeeCharacter(char:Character):Boolean {
			 var mid:FlxPoint = getMidpoint();
			 var charMid:FlxPoint = char.getMidpoint();
			 var topDist:Number = y - char.y;
			 var bottomDist:Number = (y + height) - (char.y + char.height);
			 var minMidDist:Number = 2.0;
			 
			 if (Math.abs((mid.y - charMid.y)) < minMidDist)
				return areFacingEachother(char);
			 
			 return false;
		 }
		
		public function JustHitWall():Boolean
		{
			return justTouched(LEFT | RIGHT | DOWN | UP);
		}
		
		public function Heading():Point
		{
			return mHeading;
		}
		
		public function setHeading(p:Point):void
		{
			mHeading = p.clone();
		}
		
		public function HitBox():GameObject
		{
			return mHitBox;
		}
		
		public function WeaponHitBox():GameObject
		{
			return mWeaponHitbox;
		}
		
		public function SetSpeed(speed:Number):void
		{
			WALK_SPEED = speed;
		}
		public function Speed():Number
		{
			return WALK_SPEED;
		}
		
		public function setAttacking(b:Boolean):void
		{
			mIsAttacking = b;
		}
		
		public function Attacking():Boolean
		{
			return mIsAttacking;
		}
		
		public function Strength():Number
		{
			return mStrength;
		}
		
		public function setPosition(p:Point)
		{
			this.x = p.x;
			this.y = p.y;
		}
		
		public function getReactionMgr():ReactionManager
		{
			return mReactions;
		}
		
		public function decreaseHeltah(num:Number):void
		{
			mHealth -= num;
		}
		
		public function setHealth(num:Number):void
		{
			mHealth = num;
		}
		
		public function getHealth():Number
		{
			return mHealth;
		}
		
		public function getLookAt():Point 
		{
			return mLookAt.clone();
		}
		
		public function getDirectionToPlayer():Point
		{
			return Directions[ DirectionBetween(mGame.ActivePlayer()) ];
		}
		
		public function isReadyToDisplay():Boolean
		{
			return mAnimations.isFinishedLoading();
		}
		
		public function getBulletOrigin():Point
		{
			var pos:Point = new Point(x + mBulletOriginOffset.x, y+mBulletOriginOffset.y);
			
			return pos;
		}
		
		public function getWeapon():Weapon
		{
			return mCurrentWeapon;
		}
		
		public function fireCurrentWeapon():void
		{
			var fireRate:Number = 3.0 / 1.0;
			var factory:BulletFactory = new BulletFactory(mGame);
			mGame.getBulletMgr().addBullet(factory.createBulletFromCharacter(this, 0.5, 50));
		}
		
		public function getAnimationBasedOnLookAt(left:String, right:String, up:String, down:String):String
		{
			if (getLookAt().x < 0)
				return left;
			else if (getLookAt().x > 0)
				return right;
			else if (getLookAt().y > 0)
				return down;
			else if (getLookAt().y < 0)
				return up;
				
			return "";
		}
		
		public function setSpawnPoint(p:Point):void
		{
			mSpawnPoint = p.clone();
		}
		
		public function getSpawnPoint():Point
		{
			return mSpawnPoint.clone();
		}
		
		public function setController(controller:CharacterController)
		{
			mController = controller;
		}
		
		public function setAnimationSrc(src:String):void 
		{
			mAnimationsPath = src;
		}
		
		public function setMovementBounds(rect:FlxRect):void
		{
			mMovementBounds = new FlxRect(rect.left, rect.top, rect.width, rect.height);
		}
		
		public function getMovementBounds():FlxRect
		{
			return mMovementBounds;
		}
		
		public function getPosition():Point
		{
			return new Point(x.valueOf(), y.valueOf());
		}
		
		public function getTarget():Point
		{
			return mTargetPosition;
		}
		
		public function setTarget(p:Point):void
		{
			mTargetPosition = p.clone();
		}
		
		public function getShadowOffset():Point
		{
			return mShadowOffset.clone();
		}
		
		public function setShadowOffset(p:Point):void
		{
			mShadowOffset = p.clone();
		}
		
		public function getStrength():Number
		{
			return mStrength;
		}
		
		public function getArmorClass():Number
		{
			return mArmorClass;
		}
	}
	

}