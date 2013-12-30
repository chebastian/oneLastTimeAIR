package CharacterStates 
{
	import CharacterController.CharacterController;
	import com.adobe.protocols.dict.events.DefinitionHeaderEvent;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PlayerDeathState extends CharacterState 
	{
		var mPlayer:PirateCharacter;
		public function PlayerDeathState(char:PirateCharacter) 
		{
			super(PLAYER_DEATH_STATE, char);
			mPlayer = char;
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
				mCharacter.ChangeState(new PlayerSpawnState(mPlayer));
			}
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}