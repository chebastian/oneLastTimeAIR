package  
{
	import flash.geom.Point;
	import flash.text.engine.FontPosture;
	import GameObject;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Cell extends GameObject 
	{
		
		var mGame:PlayState;
		public function Cell(pos:Point,game:PlayState) 
		{
			super(pos.x, pos.y, null);
			mGame = game;
		}
		
		public function OnEnter():void
		{
			
		}
		
		public function OnExit():void
		{
			
		}
		
		public function OnActive():void
		{
			
		}
	}

}