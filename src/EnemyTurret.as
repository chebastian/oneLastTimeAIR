package  
{
	import AttackReactions.DamageReaction;
	import CharacterStates.TurretIdleState;
	import CharacterStates.WanderState;
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyTurret extends EnemyWalker
	{
		
		protected var mFireRate:Number;
		public function EnemyTurret(game:PlayState, pos:Point) 
		{
			super(game, pos);
			mAnimationsPath = "./media/enemy/turret/animations.txt";
			srcWH = new Point(8, 8);
			SetSpeed(0);
			mHeading = new Point( 0, 0);
		}
		
		override public function Init():void 
		{
			//super.Init();
			
			mReactions.setReaction(new DamageReaction(this, 50));
			mHitBoxSizeOffset.x = -4;
			mHitBoxSizeOffset.y = -4;
			mHitBoxPosOffset.x = 2;
			mBulletOriginOffset = new Point(2, 2);
			mStrength = 1.0;
			mHealth = 100.0;
			mCurrentWeapon = new Weapon(mGame, 1.0 / 3.0, 50, 0.5);
			mSpawnPoint = new Point(x, y);
			//ChangeState(new WanderState(this));
			mFireRate = 3;
			mHitBoxSizeOffset.x = -4;
			mHitBoxSizeOffset.y = -4;
			mHitBoxPosOffset.x = 2;
			updateLookAt();
			ChangeState(new TurretIdleState(this));
			immovable = true;
			//mHeading.x = -1;
		}
		
		override public function onEnter():void 
		{
			
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			Animation_Attack_L = "rise";
			Animation_Attack_R = "rise";
			changeAnimationBasedOnHeading();
			ChangeAnimation("idleDown");
		}
		
		public function changeAnimationBasedOnHeading():void
		{
			if (getLookAt().x < 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("turretMirror"));
			else if(getLookAt().x > 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("turret"));
			else if (getLookAt().y > 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("turretDown"));
			else if (getLookAt().y < 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("turretUp"));
		}
		
		override public function update():void 
		{
			StopMoving();
			super.update();
			changeAnimationBasedOnHeading();
		}
		
		override public function lookForPlayer():void 
		{
			
		}
		
		override public function canSeeCharacter(char:Character):Boolean 
		{
			if (areFacingEachother(char))
			{
				var mid:FlxPoint = getMidpoint();
				var charMid:FlxPoint = char.getMidpoint();
				var topDist:Number = y - char.y;
				var bottomDist:Number = (y + height) - (char.y + char.height);
			
				var xD:Number = mid.x - charMid.x;
				var yD:Number = mid.y - charMid.y;
				xD *= getLookAt().y;
				yD *= getLookAt().x;
				
				var minMidDist:Number = 2.0;
				
				if ((Math.abs(xD) < minMidDist) && Math.abs(xD) > 0.0)
				{
					return areFacingEachother(char);
				}
				else if ((Math.abs(yD) < minMidDist) && Math.abs(yD) > 0.0)
				{
					return areFacingEachother(char);
				}
			}
			
			return false;/*super.canSeeCharacter(char);*/
		}
		
		public function getFireRate():Number
		{
			return mFireRate;
		}
		
		override protected function updateLookAt():void 
		{
			super.updateLookAt();
			if (Math.abs(mHeading.y) > 0)
			{
				mLookAt.y = mHeading.y;
			}
		}
		
	}

}