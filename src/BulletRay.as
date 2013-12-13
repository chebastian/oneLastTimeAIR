package  
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BulletRay extends Bullet 
	{
		var rayBegin:GameObject;
		var rayMiddle:GameObject;
		var rayEnd:GameObject;
		
		public function BulletRay(game:PlayState, _x:Number, _y:Number, dir:Point) 
		{
			super(game, _x, _y, dir);
			mAnimationsPath = "./media/player/bullet/ray_animations.txt";
			srcWH = new Point(8, 9);
		}
		
		override public function Init():void 
		{
			super.Init();
			
			//rayBegin = new GameObject(x, y, mAnimations.getAnimation("rayStart").src);
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			ChangeAnimation("ray");
		}
	}

}