package CharacterStates 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class JumperIdleState extends CharacterState 
	{
		var mLastTime:Number;
		var mJumpRate:Number;
		var timer:Timer;
		public function JumperIdleState(char:Character) 
		{
			super(JUMPER_IDLESTATE,char);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			mLastTime = 0;
			mJumpRate = 300;
			timer = new Timer(300, 1);
			timer.addEventListener(TimerEvent.TIMER, onTimerComplete);
			timer.start();
			mCharacter.ChangeAnimation("idle");
		}
		
		protected function onTimerComplete(e:TimerEvent)
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,onTimerComplete);
			mCharacter.ChangeState(new JumpingState(mCharacter));
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
			timer.removeEventListener(TimerEvent.TIMER, onTimerComplete);
			timer.stop();
			timer = null;
		}
		
	}

}