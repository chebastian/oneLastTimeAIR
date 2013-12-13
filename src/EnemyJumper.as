package  
{
	import CharacterController.JumpController;
	import CharacterStates.IdleState;
	import CharacterStates.JumperIdleState;
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyJumper extends EnemyWalker 
	{
		var mShadow:FlxSprite;
		public function EnemyJumper(game:PlayState, pos:Point) 
		{
			super(game, pos);
			mAnimationsPath = "./media/enemy/jumper/animations.txt";
			srcWH = new Point(8, 8);
			mHeading = new Point( 0, 0);
			allowCollisions = NONE;
			mShadow = new FlxSprite(pos.x, pos.y, mGame.getResources().getResource("playerShadow"));
		}
		
		override public function Init():void 
		{
			super.Init();
			ChangeState(new JumperIdleState(this));
			SetSpeed(50);
		}
		
		override public function lookForPlayer():void 
		{
			
		}
		
		override public function draw():void 
		{
			//if (!FlxG.keys.pressed("R"))
			{
				updateShadow();
				mShadow.draw();
			}
			super.draw();
		}
		
		protected function updateShadow():void
		{
			mShadow.x = x + mShadowOffset.x;
			mShadow.y = y + mShadowOffset.y;
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			ChangeAnimation("jump");
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			if (super.OnHitCharacter(char))
			{
				allowCollisions = UP | DOWN | LEFT | RIGHT;
				StopMoving();
				return true;
			}
			allowCollisions = NONE;
			return false;//super.OnHitCharacter(char);
		}
	}

}