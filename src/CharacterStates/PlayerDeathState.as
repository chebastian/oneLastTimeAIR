package CharacterStates 
{
	import CharacterController.CharacterController;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PlayerDeathState extends CharacterState 
	{
		
		public function PlayerDeathState(char:Character) 
		{
			super(PLAYER_DEATH_STATE, char);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			mCharacter.setController(new CharacterController(mCharacter, game));
			mCharacter.ChangeAnimation("death");
			mCharacter.StopMoving();
		}
		
		override public function OnUpdate():void 
		{
			if (mCharacter.finished)
			{
				mCharacter.ChangeState(new PlayerSpawnState(mCharacter));
			}
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}