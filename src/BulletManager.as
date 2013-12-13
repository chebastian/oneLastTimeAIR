package  
{
	import com.adobe.utils.IntUtil;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BulletManager 
	{
		private var mGame:PlayState;
		private var mBullets:FlxGroup;
		static  var OWNER_PLAYER:int = 0;
		static var OWNER_ENEMY:int = 1;
		static var OWNER_LEVEL:int = 2;
		
		public function BulletManager(game:PlayState) 
		{
			mGame = game;
			mBullets = new FlxGroup();
		}
		
		public function createBullets(num:int):void
		{
			
		}
		
		public function addBullet(bullet:Bullet):void
		{
			mBullets.add(bullet);
			addToScene(bullet);
		}
		
		private function addToScene(bull:Bullet):void
		{
			mGame.LAYER_ENEMY.add(bull);
		}
		
		public function getActiveBullets():FlxGroup
		{
			var aliveBullets:FlxGroup = new FlxGroup();
			for each(var bullet:Bullet in mBullets.members)
			{
				if (bulletIsActive(bullet))
				{
					aliveBullets.add(bullet);
				}
			}
			
			return aliveBullets;
		}
		
		public function getActiveBulletsFromOwner(owner:int):FlxGroup
		{
			var aliveBullets:FlxGroup;
			for each(var bullet:Bullet in mBullets.members)
			{
				if (bulletIsActive(bullet)&& bullet.Owner == owner)
				{
					aliveBullets.add(bullet);
				}
			}
			
			return aliveBullets;
		}
		
		public function removeInactiveBullets():void
		{
			/*for each(var bull:Bullet in mBullets.members)
			{
				if (bull.isTimeToDie())
					mBullets.remove(bull,true);
			}*/
			
			var toDelete:FlxGroup = new FlxGroup();
			for (var i:int = 0; i < mBullets.length; i++)
			{
				var b:Bullet = mBullets.members[i];
				if (b.isTimeToDie())
					toDelete.add(b);
			}
			
			for each(var b:Bullet in toDelete.members)
			{
				removeBullet(b);
			}
			
		}
		
		public function removeAllBullets():void
		{
			mBullets.kill();
			mBullets.clear();
		}
		
		public function removeBulletAtIndex(index:int):void 
		{
			var b:Bullet = mBullets.members[index];
			removeFromScene(b);
			mBullets.remove(b);
		}
		
		public function removeBullet(bull:Bullet):void
		{
			removeFromScene(bull);
			mBullets.remove(bull, true);
		}
		
		private function removeFromScene(bull:Bullet):void
		{
			mGame.LAYER_ENEMY.remove(bull);
		}
		
		private function bulletIsActive(bullet:Bullet):Boolean
		{
			return bullet.active == true;
		}
	}

}