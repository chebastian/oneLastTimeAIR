package  
{
	import AttackReactions.DamageReaction;
	import CharacterStates.DamagedState;
	import CharacterStates.HitImmuneState;
	import CharacterStates.IdleState;
	import CharacterStates.WalkerChargeState;
	import CharacterStates.WanderState;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyWalker extends Enemy 
	{
		
		public function EnemyWalker(game:PlayState, pos:Point) 
		{
			super(game, pos);
			mAnimationsPath = "./media/enemy/awlker/animations.txt";
			srcWH = new Point(8, 9);
			//InitAnimations();
			SetSpeed(10);
		}
		
		override public function Init():void 
		{
			super.Init();
			mReactions.setReaction(new DamageReaction(this, 50));
			ChangeState(new WanderState(this));
			mHitBoxSizeOffset.x = -4;
			mHitBoxSizeOffset.y = -4;
			mHitBoxPosOffset.x = 2;
			mBulletOriginOffset = new Point(0, 2);
			mSpawnPoint = new Point(x, y);
		}
		
		override public function InitAnimations():void 
		{
			super.InitAnimations();
			Animation_WalkDown = "";
			Animation_WalkUp = "";
			Animation_WalkLeft = "walkLeft";
			Animation_WalkRight = "walkRight";
			Animation_Attack_L = "attackL";
			Animation_Attack_R = "attackR";
		}
		
		override public function update():void 
		{
			super.update();
			//updateWalkingAnimation();
			lookForPlayer();
		}
		
		override protected function updateLookAt():void 
		{
			if (mHeading.x > 0 || mHeading.x < 0)
			{
				mLookAt.x = mHeading.x;
				mLookAt.normalize(1.0);
				mLookAt.y = 0;
			}
			mLookAt.y = 0;
		}
		
		public function lookForPlayer():void
		 {
			if(canSeeCharacter(mGame.ActivePlayer()))
			{
				var d:Number = distanceBetween(mGame.ActivePlayer());
				var minD:Number = 64;
				trace(d);
				if(!IsInState(CharacterState.DEATH_STATE) && !IsInState(CharacterState.DAMAGED_STATE) && !IsInState(WalkerChargeState.WALKER_STATEID) && d < minD && canSeeCharacter(mGame.ActivePlayer()))
				{
					PushState(new WalkerChargeState(this));
				}
			}
		 }
		
		override public function draw():void 
		{
			super.draw();
			//drawDebug();
			//mHitBox.drawDebug();
		}
		public function updateWalkingAnimation():void
		{
			if (mHeading.x < 0)
				ChangeAnimation("walkLeft");
			else 
				ChangeAnimation("walkRight");
				
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			ChangeAnimation("walkLeft");
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			if (!alive || !char.alive)
				return false;
				
			if (char.Attacking() && mHitBox.overlaps(char))
			{
				if (areLookingAtEachOther(char) || (char.getStrength() > this.getArmorClass()))
				{
					PushState(new DamagedState(this));
					char.OnHitCharacter(this);
					mReactions.getReaction().onAttacked(char);
					FlxG.play(mGame.getResources().getSound("bullet_hit_enemy"),1.0);
				
					return true;
				}
				
				else
				{
					PushState(new HitImmuneState(this));
					FlxG.play(mGame.getResources().getSound("immune1"),1.0);
					return true;
				}
			}
			return mHitBox.overlaps(char);
		}
		
		protected function areLookingAtEachOther(char:Character):Boolean
		{
			var toChar:Point = char.getLookAt();
			toChar.normalize(1.0);
			
			var dot:Number = (getLookAt().x * toChar.x) + (getLookAt().y * toChar.y);
			
			
			var result = areFacingEachother(char) && dot < 0.0;
			
			return result;
		}
		
		override public function getLookAt():Point 
		{
			return mLookAt.clone();
		}
		
	}

}