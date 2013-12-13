package CharacterStates 
{
	import adobe.utils.CustomActions;
	import CharacterController.JumpController;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class JumpingState extends CharacterState 
	{
		var mJumpDir:Point;
		var mGame:PlayState;
		var mTimer:Timer;
		var mTargetPos:Point;
		var mOriginalPos:Point;
		
		var mTargetTime:Number;
		var mTotalTime:Number;
		
		public function JumpingState(char:Character) 
		{
			super(CharacterState.JUMPING_STATE, char);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			mGame = game;
			mCharacter.setController(new JumpController(mCharacter, game));
			mCharacter.ChangeAnimation(mCharacter.Animation_Jump);
			mTimer = new Timer(2000 * Math.random(), 0);
			//mTimer.addEventListener(TimerEvent.TIMER, setNewJumpDirection);
			mTimer.start();
			
			mJumpDir = mCharacter.getPosition();
			mTargetPos = mCharacter.getPosition();
			mOriginalPos = mCharacter.getPosition();
	  		mCharacter.StopMoving();
			mTotalTime = 0;
			mTargetTime = Math.random();
			setNewJumpDirection(null);
		}
		
		protected function setNewJumpDirection(e:TimerEvent):void
		{
			mOriginalPos = mCharacter.getPosition().clone();
			mTargetPos = mCharacter.getTarget().clone();
			mTotalTime = 0;
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			//mCharacter.Move(mJumpDir, mCharacter.Speed())
			updatePos();
		}
		
		protected function updatePos():void
		{
			mTotalTime += FlxG.elapsed;
			if (mTotalTime >= 1.0)
			{
				mCharacter.ChangeAnimation("landing");
				if (mCharacter.finished)
					mCharacter.ChangeState(new JumperIdleState(mCharacter));
					
				return;
			}
				
			var tx:Number = mTargetPos.x.valueOf();
			var ty:Number= mTargetPos.y.valueOf();
			var cx:Number = mOriginalPos.x;
			var cy:Number = mOriginalPos.y;
			
			var dx:Number = slerp(cx, tx, mTotalTime);
			var dy:Number = slerp(cy, ty, mTotalTime);
			var ddy = dy;
			//var ddy = circularInterpolate(dy, dy + 5, mTotalTime);
			dy = circularInterpolate(dy, dy - 10, mTotalTime);
			//var sc:Number = 	circularInterpolate(1.0, 1.2, mTotalTime);
			//mCharacter.scale.x = sc;
			//mCharacter.scale.y = sc;
			
			mCharacter.x = dx;
			mCharacter.y = dy;
			mCharacter.setShadowOffset(new Point(2, ddy-dy));
		}
		
		protected function slerp(a:Number, target:Number, dist:Number):Number
		{
			var res:Number = 0;
			var td:Number = target - a;
			
			//dist = Math.sin(dist * Math.PI / 2);
			dist = 0.5 - Math.cos( -dist * Math.PI) * 0.5;
			//dist = Math.sin(dist * Math.PI);
			res = a.valueOf();
			res += td * dist;
			//return (start + percent*(end - start));
			return res;
		}
		
		protected function circularInterpolate(a:Number, target:Number, dist:Number):Number
		{
			var res:Number = 0;
			var td:Number = target - a;
			
			dist = Math.sin(dist * Math.PI);
			res = a.valueOf();
			res += td * dist;
			return res;
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}