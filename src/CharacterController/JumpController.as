package CharacterController 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class JumpController extends CharacterController 
	{
		public function JumpController(char:Character,game:PlayState) 
		{
			super(char, game);
			mCharacter.setTarget(mGame.ActivePlayer().getPosition().clone());
		}
		
		override public function update():void 
		{
			super.update();
			mCharacter.setTarget(mGame.ActivePlayer().getPosition().clone());
		}
		
	}

}