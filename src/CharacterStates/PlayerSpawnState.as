package CharacterStates 
{
	import CharacterController.*;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PlayerSpawnState extends CharacterState 
	{
		var mGame:PlayState;
		public function PlayerSpawnState(char:Character) 
		{
			super(CHARACTER_SPAWN_STATE, char);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			FlxG.flash(0x00000000, 0.5);
			mGame = game;
			super.OnEnter(game);
			mCharacter.ChangeAnimation("spawn");
			mCharacter.setPosition(mCharacter.getSpawnPoint());
			mCharacter.setController(new CharacterController(mCharacter, game));
			mCharacter.setHealth(100);
			game.ActiveLevel().ActiveRoom().reloadRoom();
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			if (mCharacter.finished)
			{
				mCharacter.ChangeState(new CharacterWalking(mCharacter));
				mCharacter.setController(new InputController(mCharacter, mGame));
			}
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}