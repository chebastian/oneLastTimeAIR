package AttackReactions 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class ReactionCooldown extends AttackReaction 
	{
		
		protected var mCooldown:Number;
		protected var mDate:Date;
		protected var mTimeStamp:Number;
		
		public function ReactionCooldown(char:Character, time:Number) 
		{
			super(char);
			mCooldown = time;
			mTimeStamp = 0.0;
			mDate = new Date();
			createTimeStamp();
		}
		
		override public function onAttacked(attacker:Character):void
		{
			if (cooldownReached())
			{
				mCharacter.getReactionMgr().popReaction()
				mCharacter.getReactionMgr().getReaction().onAttacked(attacker);
			}
		}
		
		private function createTimeStamp():void
		{
			if(mTimeStamp <= 0.0)
				mTimeStamp = mDate.time;
		}
		
		private function cooldownReached():Boolean
		{
			if (timeSinceStamp() >= mCooldown)
				return true;
				
			return false;
		}
		
		private function timeSinceStamp():Number
		{
			mDate = new Date();
			var time = mDate.time - mTimeStamp;
			return time;
		}
		
	}

}