package  
{
	import CharacterStates.DeathState;
	import CharacterStates.WanderState;
	import com.adobe.protocols.dict.util.CompleteResponseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Enemy extends Character
	{
		
		public function Enemy(game:PlayState ,pos:Point) 
		{
			super(game, pos.x, pos.y);
			//mState = new WanderState(0, this);
			//allowCollisions = NONE;
		}
		
		override public function Init():void 
		{
			mAnimationFrameRate = 15;
			super.Init();
		}	
		
		override public function onEnter():void 
		{
			super.onEnter();
			//allowCollisions = LEFT | RIGHT | UP | DOWN;
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			if (char.Attacking())
			{
				return true;
			}
			
			return false;
		}
		
		override public function justTouched(Direction:uint):Boolean 
		{
			if (super.justTouched(Direction))
				return true;
				
			return super.justTouched(Direction);
		}
		
		override public function update():void 
		{
			super.update();
			if (mHealth <= 0 && !IsInState(CharacterState.DEATH_STATE))
				ChangeState(new DeathState(this));
				
		}
	}

}