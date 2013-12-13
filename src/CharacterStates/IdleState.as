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
			char.ChangeAnimation("idle");
			mId = IDLE_STATE;
		}
		
	}

}