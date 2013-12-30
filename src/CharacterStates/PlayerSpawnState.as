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
		var mChar:PirateCharacter;
		public function PlayerSpawnState(char:PirateCharacter) 
		{
			super(CHARACTER_SPAWN_STATE, char);
			mChar = char;
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			FlxG.flash(0x00000000, 0.5);
			mGame = game;
			super.OnEnter(game);
			mCharacter.ChangeAnimation("spawn");
			mCharacter.setPosition(mCharacter.getSpawnPoint());
			mCharacter.setController(new CharacterController(mChar, game));
			mCharacter.setHealth(100);
			game.ActiveLevel().ActiveRoom().reloadRoom();
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			if (mCharacter.finished)
			{
				mCharacter.ChangeState(new CharacterWalking(mChar));
				mCharacter.setController(new InputController(mChar, mGame));
			}
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}