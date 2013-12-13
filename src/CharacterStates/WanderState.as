package CharacterStates 
{
	/**
	 * ...
	 * @author ...
	 */
	import flash.geom.Point;
	import org.flixel.FlxBasic;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxRect;
	public class WanderState extends CharacterState 
	{
		var mElapsedTime:Number;
		var mTimeTillTurn:Number;
		var mMaxTimeTillTurn:Number = 3;
		
		public function WanderState(char:Character) 
		{
			super(4326749621, char);
			//mCharacter.ChangeAnimation("walkUp", GameResources.Anim_SlimeWalk);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			mCharacter.WalkInDir(new Point(1, 0));
			SetNextTurnTime();
			super.OnEnter(game);
			
			var rect:FlxRect = new FlxRect(0, 0,
			game.ActiveLevel().ActiveRoom().getRoomWidth(),
			game.ActiveLevel().ActiveRoom().getRoomHeight());
			mCharacter.setMovementBounds(rect);
		}
		
		
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			
			if (mCharacter.justTouched(FlxObject.DOWN | FlxObject.UP | FlxObject.LEFT | FlxObject.RIGHT))
			{
				OnHitWall();
			}
			else if (mElapsedTime >= mTimeTillTurn)
			{
				OnTurn();
			}
			
			updateAnimationBasedOnHeading();
			mElapsedTime += FlxG.elapsed;
		}
		
		public function updateAnimationBasedOnHeading():void
		{
			if (mCharacter.Heading().x < 0)
				mCharacter.ChangeAnimation(mCharacter.Animation_WalkLeft);
			else if (mCharacter.Heading().x > 0)
				mCharacter.ChangeAnimation(mCharacter.Animation_WalkRight);
			
			else if (mCharacter.Heading().y < 0)
				mCharacter.ChangeAnimation(mCharacter.Animation_WalkUp);
			else if (mCharacter.Heading().y > 0)
				mCharacter.ChangeAnimation(mCharacter.Animation_WalkDown);
		}
		
		public function OnHitWall():void
		{
			var rand:Number = FlxG.random();
				var rand2:Number = FlxG.random();
				var xd:Number = 1;
				var xy:Number = 1;
				if (rand > 0.5)
					xd *= -1;
				if (rand2 > 0.5)
					xy *= -1;
				if ((rand > 0.5) && (rand2 > 0.5))
					xy *= 0;
				
				
					var point:Point = new Point(xd, xy);
					point.normalize(1.0);
				//mCharacter.TurnInDir(new Point(xd,xy));
				mCharacter.TurnInDir(point);
			
			mCharacter.WalkInDir(mCharacter.Heading());
			SetNextTurnTime();
		}
		
		public function OnTurn():void
		{
			if (mElapsedTime >= mMaxTimeTillTurn)
			{
				mCharacter.TurnRight();
			}
			else
			{
				var rand:Number = FlxG.random();
				var rand2:Number = FlxG.random();
				var xd:Number = 1;
				var xy:Number = 1;
				if (rand > 0.5)
					xd *= -1;
				if (rand2 > 0.5)
					xy *= -1;
				if ((rand > 0.5) && (rand2 > 0.5))
					xy *= 0;
				
					var point:Point = new Point(xd, xy);
					point.normalize(1.0);
				//mCharacter.TurnInDir(new Point(xd,xy));
				mCharacter.TurnInDir(point);
			}
			
			mCharacter.WalkInDir(mCharacter.Heading());
			SetNextTurnTime();
		}
		
		public function SetNextTurnTime():void 
		{
			mElapsedTime = 0.0;
			mTimeTillTurn = mMaxTimeTillTurn *  FlxG.random();
		}
		
	}

}