package  
{
	import AttackReactions.DamageReaction;
	import CharacterStates.DamagedState;
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyFlyer extends EnemyWalker 
	{
		
		public function EnemyFlyer(game:PlayState, pos:Point) 
		{
			super(game, pos);
			mAnimationsPath = "./media/enemy/flyer/animations.txt";
			srcWH = new Point(7, 7);
			mHeading = new Point( 0, 0);
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			ChangeAnimation("idle");
			Animation_DamagedR = "hurt";
			Animation_DamagedL = Animation_DamagedR;
			Animation_Attack_U = Animation_DamagedR;
			Animation_DamagedD = Animation_DamagedR;
		}
		
		override public function onEnter():void 
		{
			super.onEnter();
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function lookForPlayer():void 
		{
			//super.lookForPlayer();
		}
		override public function OnHitCharacter(char:Character):Boolean 
		{
			if (!alive || !char.alive)
				return false;
				
			if (char.Attacking() && mHitBox.overlaps(char))
			{
				PushState(new DamagedState(this));
				char.OnHitCharacter(this);
				mReactions.getReaction().onAttacked(char);
				FlxG.play(mGame.getResources().getSound("bullet_hit_enemy"),1.0);
				
				return true;
			}
			
			return false;
		}
	}

}