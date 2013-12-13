package AttackReactions 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class KnockbackReaction extends AttackReaction 
	{
		var mKnockBackDist:Number;
		public function KnockbackReaction(char:Character, dist:Number) 
		{
			super(char);
			mKnockBackDist = dist;
		}
		
		override public function onAttacked():void 
		{
			//var vec: Point = mCharacter.getDirectionToPlayer();
			//vec.x = -vec.x;
			//vec.y = -vec.y;
			
			//mCharacter.Move(vec, mKnockBackDist*2);
			super.onAttacked();
		}
		
	}

}