package  RoomAssets
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BlockerWall extends RaisableWall 
	{
		
		public function BlockerWall(game:PlayState,_x:Number, _y:Number) 
		{
			super(game,_x, _y);
			setOpen(false);
		}
		
	}

}