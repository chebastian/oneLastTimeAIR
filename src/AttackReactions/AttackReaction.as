package AttackReactions 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class AttackReaction 
	{
		protected var mCharacter:Character;
		
		public function AttackReaction(char:Character) 
		{
			mCharacter = char;
		}
		
		public virtual function onAttacked(attacker:Character):void
		{
			
		}
		
	}

}