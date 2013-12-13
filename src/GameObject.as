package  
{
	import flash.automation.AutomationAction;
	import org.flixel.FlxSprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class GameObject extends FlxSprite
	{
		
		protected var mName:String;
		protected var mUniqueId:uint;
		protected static var mIdCounter:uint = 0;
		protected var mAABBOffset:Point;
		protected var mAABBWidthOffset:Number;
		protected var mAABBHeightOffset:Number;
		protected var mNotifier:EntityNotifier;
		
		public static var DIR_LEFT = 0;
		public static var DIR_RIGHT = 1;
		public static var DIR_UP = 2;
		public static var DIR_DOWN = 3;
		public static var DIR_OOB = 4;
		
		public static var Directions:Array = new Array(new Point(-1,0), new Point(1,0), new Point(0,-1), new Point(0,1));
		
		public function GameObject(_x:Number, _y:Number,graphic:Class) 
		{
			mAABBHeightOffset = 0;
			mAABBWidthOffset = 0;
			mAABBOffset = new Point(0, 0);
			
			super(_x, _y, graphic);
			mUniqueId = GetNextValidUniqueId();
			mName = "";
			drag.x = 0;
			drag.y = 0;
			mNotifier = new EntityNotifier();
		}
		
		public function setNotifier(notifier:EntityNotifier):void {
			mNotifier = notifier;
		}
		
		public function getNotifier():EntityNotifier{
			return mNotifier;
		}
		
		public function Init():void
		{
			
		}
		
		override public function draw():void 
		{
			//drawDebug();
			super.draw();
		}
		
		public function OffsetBoundingBox(pos:Point, w:Number, h:Number)
		{
			width += w; height += h;
			offset.x = pos.x; offset.y = pos.y;
		}
		
		override public function loadGraphic(Graphic:Class, Animated:Boolean = false, Reverse:Boolean = false, Width:uint = 0, Height:uint = 0, Unique:Boolean = false):FlxSprite 
		{
			var spr:FlxSprite = super.loadGraphic(Graphic, Animated, Reverse, Width, Height, Unique);
			OffsetBoundingBox(mAABBOffset, mAABBWidthOffset, mAABBHeightOffset);
			return spr;
		}
		
		public function ObjectId():uint
		{
			return mUniqueId;
		}
		
		public function Move(dir:Point, dist:Number):void
		{
			acceleration.x = dir.x * dist;
			acceleration.y = dir.y * dist;
		}
		
		public function StopMoving():void
		{
				acceleration.x = 0;
				acceleration.y = 0;
				velocity.x = 0;
				velocity.y = 0;
		}
		
		protected function GetNextValidUniqueId():uint {
			mIdCounter++;
			return mIdCounter;
		}
		
		public function IsInlineWith(obj:GameObject):Boolean
		{
			var xdistLeft = obj.x - (x );
			var xdistRight = (obj.x + obj.frameWidth) - (x + frameWidth*0.5);
			
			var ydistTop = obj.y - y;
			var ydistBottom = (obj.y + obj.frameHeight) - (y + frameHeight);
			
			if ((xdistLeft < frameWidth && xdistRight > 0) ||
				(xdistLeft < 0 && xdistRight > 0))
			{
				if (ydistTop < 0)
					return true;
				else
					return true;
			}
			else if ( (ydistTop < frameHeight && ydistBottom > 0) ||
						(ydistTop < 0 && ydistBottom > 0))
			{
				if (xdistLeft > 0)
					return true;
					
				else return true;
			}
			
			return false;
		}
		
		public function DirectionBetween(obj:GameObject):uint
		{
			var xdistLeft = obj.x - x;
			var xdistRight = (obj.x + obj.frameWidth) - x;
			
			var ydistTop = obj.y - y;
			var ydistBottom = (obj.y + obj.frameHeight - y);
			
			if ((xdistLeft < frameWidth && xdistRight > 0) ||
				(xdistLeft < 0 && xdistRight > 0))
			{
				if (ydistTop < 0)
					return DIR_DOWN;
				else
					return DIR_UP;
			}
			
			else if ( (ydistTop < frameHeight && ydistBottom > 0) ||
						(ydistTop < 0 && ydistBottom > 0))
			{
				if (xdistLeft > 0)
					return DIR_LEFT;
					
				else return DIR_RIGHT;
			}
			
			return DIR_OOB;
		}
		
		public function distanceBetween(obj:GameObject):Number 
		{
			var xd:Number = obj.x - x;
			var yd:Number = obj.y - y;
			var len:Number = (xd * xd) + (yd * yd);
			return Math.sqrt(len);
		}
		
		
		
		public function Equals(obj:GameObject):Boolean
		{
			return (mUniqueId == obj.GetUniqueId());
		}
		
		public function GetUniqueId():uint
		{
			return mUniqueId;
		}
		
		public function GetName():String
		{
			return mName;
		}
	}

}