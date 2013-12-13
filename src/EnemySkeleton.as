package  
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemySkeleton extends Enemy 
	{
		
		public function EnemySkeleton(game:PlayState, pos:Point) 
		{
			super(game, pos);
		}
		
		override public function InitAnimations():void 
		{
			loadAnimationFromJSON("./media/skeleton/animations.txt");
			super.InitAnimations();
		}
		
	}

}