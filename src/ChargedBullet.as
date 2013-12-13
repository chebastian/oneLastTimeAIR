package  
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class ChargedBullet extends Bullet 
	{
		
		public function ChargedBullet(game:PlayState, _x:Number, _y:Number, dir:Point) 
		{
			super(game, _x, _y, dir);
			mAnimationsPath = "./media/player/bullet/charge_anims.txt";
		}
		
		override public function Init():void 
		{
			super.Init();
			mStrength = 2.0;
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
		}
		
	}

}