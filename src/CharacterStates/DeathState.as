package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class DeathState extends CharacterState 
	{
		
		public function DeathState(char:Character) 
		{
			super(DEATH_STATE, char);
			mStateTimer = 0;
		}
		
		override public function OnEnter(game:PlayState ):void 
		{
			super.OnEnter(game);
			mCharacter.ChangeAnimation("death");
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			if (mCharacter.finished)
			{
				mCharacter.kill();
			}
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}