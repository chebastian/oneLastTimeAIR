package CharacterStates 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author ...
	 */
	public class AttackState extends CharacterState 
	{
		var mAttackCountDown:Number;
		
		public function AttackState(char:Character) 
		{
			
			super(ATTACK_STATE, char);
			
			mAttackCountDown = 0.2;
			//mCharacter.ChangeAnimation("idle", null);
			
			mId = ATTACK_STATE;
				
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			//mCharacter.ChangeAnimation("attack", null);
			if(mCharacter.Heading().x < 0)
				mCharacter.ChangeAnimation("attackL", null);
			else if(mCharacter.Heading().x != 0)
				mCharacter.ChangeAnimation("attackR", null);
			
			else if (mCharacter.Heading().y == 1)
				mCharacter.ChangeAnimation("attackD", null);
				
			else if (mCharacter.Heading().y < 0)
				mCharacter.ChangeAnimation("attackU", null);
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			mCharacter.StopMoving();
			if (mCharacter.finished)
			{
				mCharacter.ChangeState(new IdleState(0, mCharacter));
			}
			trace("ATTACKING");
		}
		
		public function AttackInDirection(dir:Point):void
		{
			var attackObj:GameObject = new GameObject(mCharacter.x, mCharacter.y,null);
		}
	}

}