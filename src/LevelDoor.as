package  
{
	import flash.geom.Point;
	import flash.net.NetStreamMulticastInfo;
	import flash.text.engine.FontPosture;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class LevelDoor extends GameObject
	{
		var mPos:Point;
		var mArivingPos:Point;
		var mRoomToLoad:String;
		var mOpen:Boolean;
		var mDoorId:uint;
		public function LevelDoor(pos:Point,exit:Point,to:String,open:Boolean = true) 
		{
			super(pos.x, pos.y, null);
			mPos = pos; mArivingPos = exit;
			mRoomToLoad = to;
			mOpen = open;
			mDoorId = mUniqueId;
		}
		
		public function SetId(id:uint)
		{
			mDoorId = id;
			mUniqueId = mDoorId;
		}
		
		public function FilePath():String
		{
			return mRoomToLoad;
		}
		
		public function DoorIsOpen()
		{
			return mOpen;
		}
		
	}

}