package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class StateManager 
	{
		
		var states:Array;
		public function StateManager() 
		{
			states = new Array();
		}
		
		public function changeState(state:CharacterState):void
		{
			removeCurrentState();
			states.push(state);
		}
		
		public function hasState():Boolean
		{
			return states.length > 0;
		}
		
		public function pushState(state:CharacterState):void
		{
			states.push(state);
		}
		
		public function popState():CharacterState
		{
			return states.pop();
		}
		
		public function getCurrentState():CharacterState
		{
			return states[states.length-1];
		}
		
		protected function removeCurrentState():void
		{
			if (states[states.length-1] != null)
			{
				if (states.length >= 1)
					states.pop(); 
			}
		}
		
	}

}