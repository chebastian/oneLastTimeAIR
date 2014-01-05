package CharacterStates 
{
	/**
	 * ...
	 * @author ...
	 */
	
	 import Character;
	 
	public class IdleState extends CharacterState 
	{
		
		public function IdleState(id:uint, char:Character) 
		{
			super(id, char);
			mId = IDLE_STATE;
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			mCharacter.ChangeAnimation("idle");
			super.OnEnter(game);
		}
		
	}

}