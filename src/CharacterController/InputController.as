package CharacterController 
{
	import CharacterStates.AttackState;
	import CharacterStates.CharacterWalking;
	import CharacterStates.IdleState;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class InputController extends CharacterController 
	{
		protected var mKeysDown:Dictionary;
		public function InputController(char:Character,game:PlayState) 
		{
			super(char, game);
			char.ChangeState(new CharacterWalking(mCharacter));
			mKeysDown = new Dictionary();
		}
		
		override public function update():void 
		{
			super.update();
			handleInput();
		}
		
		protected function handleInput():void
		{
			var speed:Number = mCharacter.Speed();
				
			if (mCharacter.IsInState(CharacterState.ATTACK_STATE) || mCharacter.IsInState(CharacterState.DAMAGED_STATE) )
				return;
				
			if (FlxG.keys.justPressed("A")) 
			{
				mCharacter.ChangeState(new AttackState(mCharacter));
			}
				
			else if (FlxG.keys.pressed("LEFT"))
			{
				mCharacter.Move(new Point( -1, 0), speed);
				//mCharacter.ChangeAnimation(this.Animation_WalkLeft);
			}
			
			else if (FlxG.keys.pressed("RIGHT"))
			{
				mCharacter.Move(new Point( 1, 0), speed);
				//ChangeAnimation(this.Animation_WalkRight);
			}
			else if (FlxG.keys.pressed("UP"))
			{
				mCharacter.Move(new Point( 0, -1), speed);
				//mCharacter.ChangeAnimation(this.Animation_WalkUp);
			}
			else if (FlxG.keys.pressed("DOWN"))
			{
				mCharacter.Move(new Point( 0, 1), speed);
				//mCharacter.ChangeAnimation(this.Animation_WalkDown);
			}
			else
			{
				mCharacter.StopMoving();
				mCharacter.ChangeAnimation("idle");
				//mCharacter.ChangeState(new IdleState(CharacterState.IDLE_STATE, mCharacter));
			}
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				var factory:BulletFactory = new BulletFactory(mGame);
				var bull:Bullet = new Bullet(mGame, 0, 0, new Point(0, 0));
				bull = factory.setupBulletByCharacter(mCharacter, bull);
				mGame.getBulletMgr().addBullet(bull);
			}
			if (keyWasHeld("SPACE", 500))
			{
				var factory:BulletFactory = new BulletFactory(mGame);
				var bull:Bullet = new ChargedBullet(mGame, 0, 0, new Point(0, 0));
				bull = factory.setupBulletByCharacter(mCharacter, bull);
				mGame.getBulletMgr().addBullet(bull);
			}
		}
		
		protected function keyWasHeld(key:String,milliseconds:Number):Boolean
		{
			if (FlxG.keys.justPressed(key))
			{
				var date:Date = new Date();
				mKeysDown[key] = date.getTime();
			}
			else if (FlxG.keys.justReleased(key))
			{
				if (!mKeysDown.hasOwnProperty(key))
					return false;
					
				var date:Date = new Date();
				var time:Number = date.getTime();
				var d:Number = mKeysDown[key];
				
				return (time - d) > milliseconds;
				
			}
			return false;
		}
		
	}

}