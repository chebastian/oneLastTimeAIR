package CharacterController 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class CharacterController 
	{
		var mCharacter:Character;
		var mGame:PlayState;
		public function CharacterController(char:Character,game:PlayState) 
		{
			mCharacter = char;
			mGame = game;
		}
		
		public virtual function update():void
		{
			
		}
		
	}

}