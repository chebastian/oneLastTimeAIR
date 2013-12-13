package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class CellLevelPortal extends GameObject 
	{
		
		var mTo:String;
		var mFrom:String;
		var mIdentifier:String;
		var mRoom:CellRoom;
		var mExitDir:Point;
		var Activated:Boolean;
		public function CellLevelPortal(room:CellRoom,_x:Number, _y:Number,from:String, to:String,identifier:String) 
		{
			super(_x, _y, null);
			mTo = to;
			mFrom = from;
			width = 32;
			height = 32;
			this.moves = false;
			this.immovable = true;
			solid = true;
			mIdentifier = identifier;
			mRoom = room;
			mExitDir = new Point(1, 1);
			Activated = false;
		}
		
		public function getDestination():String
		{
			return mTo;
		}
		
		public function getOrigin():String {
			return mFrom;
		}
		
		public function getIdentifier():String
		{
			return mIdentifier;
		}
		
		public function getRoom():CellRoom
		{
			return mRoom;
		}
		
		public function passThroughPortal(p:PlayerCharacter):void
		{
			p.x = x;
			p.y = y;
			p.x += mExitDir.x * (p.width*2);
			p.y += mExitDir.y * (p.height*2);
		}
		
		public function onCompleteLoad():void
		{
			
		}
		
	}

}