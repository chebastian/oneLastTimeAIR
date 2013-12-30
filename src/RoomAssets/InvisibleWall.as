package  RoomAssets
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class InvisibleWall extends GameObject 
	{
		
		public function InvisibleWall(_x:Number, _y:Number,w:Number, h:Number)
		{
			super(_x, _y, null);
			width = w;
			height = h;
			solid = true;
			this.velocity.x = 0;
			this.velocity.y = 0;
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
			immovable = true;
			moves = false;
		}
		
		override public function Init():void 
		{
			super.Init();
			
			
		}
		
		override public function draw():void 
		{
			//super.draw();
			//StopMoving();
			drawDebug(null);
		}
		
	}

}