package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	
	 import org.flixel.FlxG;
	 
	public class SleepState extends CharacterState 
	{
		var mSleepTime:Number;
		public static var SLEEPSTATE_ID:int = 999000;
		
		public function SleepState(char:Character, float sleepTime) 
		{
			super(SLEEPSTATE_ID, char);
			mSleepTime = sleepTime;
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			countDownTimer(FlxG.elapsed);
			
			if (timerReachedGoal())
			{
				mCharacter.ChangeState(new IdleState(0, mCharacter));
			}
		}
		
		private function countDownTimer(elapsed:Number)
		{
			mSleepTime -= elapsed;
		}
		
		private function timerReachedGoal():Boolean
		{
			return mSleepTime <= 0.0;
		}
		
	}

}