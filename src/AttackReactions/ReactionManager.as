package AttackReactions 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class ReactionManager 
	{
		protected var mChar:Character;
		
		protected var mCurrentReaction:AttackReaction;
		protected var mReactionQueue:Array;
		
		public function ReactionManager(char:Character) 
		{
			mChar = char;
			mReactionQueue = new Array();
			setReaction(new AttackReaction(mChar));
		}
		
		public function setReaction(reac:AttackReaction):void
		{
			mCurrentReaction = reac;
			mReactionQueue.pop();
			mReactionQueue.push(reac);
		}
		
		public function pushReaction(reac:AttackReaction):void
		{
			mReactionQueue.push(reac);
		}
		
		public function popReaction():AttackReaction
		{
			return mReactionQueue.pop();
		}
		
		public function getReaction():AttackReaction
		{
			return mReactionQueue[mReactionQueue.length - 1];
		}
	}

}