package AttackReactions 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class DamageReaction extends AttackReaction 
	{
		var mDamage:Number;
		public function DamageReaction(char:Character, damage:Number) 
		{
			mDamage = damage;
			super(char);
		}
		
		override public function onAttacked(attacker:Character):void 
		{
			super.onAttacked(attacker);
			mCharacter.decreaseHeltah(mDamage);
		}
		
	}

}