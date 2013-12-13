package AttackReactions 
{
	import RoomAssets.WallSwitch;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class SwitchReaction extends AttackReaction 
	{
		protected var mSwitch:WallSwitch;
		public function SwitchReaction(sw:WallSwitch) 
		{
			super(sw);
			mSwitch = sw;
		}
		
		override public function onAttacked(attacker:Character):void 
		{
			mSwitch.toggleOpen();
			mSwitch.getReactionMgr().pushReaction(new ReactionCooldown(mSwitch, 200));
		}
		
	}

}