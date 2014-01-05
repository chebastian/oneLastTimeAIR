package Tests 
{
	import CharacterStates.IdleState;
	import CharacterStates.StateManager;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class StateManagerTest 
	{
		var manager:StateManager;
		public function StateManagerTest() 
		{
			manager = new StateManager();
			
			manager.changeState(new CharacterState(0, null));
			manager.changeState(new CharacterState(0, null));
			
			manager.pushState(new CharacterState(10, null));
			manager.popState();
			manager.pushState(new CharacterState(29, null));
			manager.pushState(new CharacterState(39, null));
			
			manager.changeState(new CharacterState(20, null));
		}
		
	}

}