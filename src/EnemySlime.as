package  
{
	import AttackReactions.DamageReaction;
	import AttackReactions.KnockbackReaction;
	import CharacterStates.DamagedState;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import Enemy;
	import flash.utils.Timer;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPath;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemySlime extends Enemy
	{
	
		var mSlimeMinTime:Number = 0.5;
		var mSlimeMaxTime:Number = 1.5;
		var mCurrentSlimeTime:Number;
		var mTimeSinceSlime:Number;
		var mSlimeTimer:Timer;
		
		var mSlimeTrails:FlxGroup;
	
		
		public function EnemySlime(game:PlayState, pos:Point) 
		{
			super(game,pos);
			loadGraphic(GameResources.Anim_SlimeWalk, false, false, 32, 32, false);
			
			mCurrentSlimeTime = mSlimeMinTime;
			mSlimeTimer = new Timer(mCurrentSlimeTime, 0);
			mSlimeTimer.addEventListener(TimerEvent.TIMER, AddSlimeTrail);
			
			WALK_SPEED = 50.0;
			mSlimeTrails = new FlxGroup();
			
			addAnimation("damaged", [0, 1, 2, 3], mAnimationFrameRate);
			addAnimation("death", [0, 1, 2, 3], mAnimationFrameRate);
			ChangeAnimation("walkUp");
			
			
			mReactions.setReaction(new DamageReaction(this, 50));
			//mReactions.setReaction(new DamageReaction(this, 50));
		}
		
		function AddSlimeTrail()
		{
			var pos:Point = new Point(0,0);
			var rot:Number = 0.0;
			var scale_x:Number = Math.random();
			var scale_y:Number = Math.random();
			
			var trail:GameObject = new GameObject(x, y, GameResources.Anim_SlimeTrail);
			trail.scale.x = scale_x;
			trail.scale.y = scale_y;
			
			mSlimeTrails.add(trail);
		}
		
		
		override public function update():void 
		{
			super.update();
		}
			
		override public function OnHitCharacter(char:Character):Boolean 
		{
			if (char.Attacking() && char.IsFacingCharacter(this))
			{
				var state:DamagedState = new DamagedState(this);
				if (!IsInState(CharacterState.DAMAGED_STATE) && !IsInState(CharacterState.DEATH_STATE))
				{
					if (FlxG.collide(char.WeaponHitBox(),HitBox()))
					{
						super.OnHitCharacter(char);
						ChangeState(new DamagedState(this));
						mReactions.getReaction().onAttacked(char);
						return true;
					}
				}
			}
			
			return false;
		}
		
	}

}