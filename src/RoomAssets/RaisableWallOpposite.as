package  RoomAssets
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class RaisableWallOpposite extends RaisableWall 
	{
		
		public function RaisableWallOpposite(game:PlayState,_x:Number, _y:Number) 
		{
			super(game,_x, _y);
		}
		
		override public function Init():void 
		{
			addAnimation("open", [2]);
			addAnimation("closed", [3]);
			play("open");
		}
		
		override public function setOpen(isOpen:Boolean):void 
		{
			super.setOpen(isOpen);
			solid = isOpen;
		}
		
		override protected function changeAnimationState(open:Boolean):void 
		{
			if (!open)
				play("open")
			else
				play("closed");
		}
		
		
		
		override public function toggleOpenClosed():Boolean 
		{
			return super.toggleOpenClosed();
		}
		
		
	}

}