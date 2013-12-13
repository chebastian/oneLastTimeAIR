package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EntityObserver 
	{
		protected var mUniqueId:int;
		
		public function EntityObserver(uniqueId:int) 
		{
			mUniqueId = uniqueId;
		}
		
		public virtual function onNotify():void {
			
		}
		
		public function getId():int 
		{
			return mUniqueId;
		}
		
	}

}