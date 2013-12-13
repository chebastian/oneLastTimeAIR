package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class CellEvent 
	{
		public var ID:uint;
		public var State:Boolean;
		public var Owner:Cell;
		
		public function CellEvent(owner:Cell,id:uint, state:Boolean) 
		{
			Owner = owner;
			ID = id;
			State = state;
		}
		
	}

}