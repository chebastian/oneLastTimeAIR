package  
{
	import com.adobe.utils.IntUtil;
	import flash.geom.Point;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BulletTest 
	{
		var mGame:PlayState;
		var Manager:BulletManager;
		public function BulletTest(game:PlayState) 
		{
			mGame = game;
			Manager = new BulletManager(mGame);
		}
		
		public function creation():void
		{
			var factory:BulletFactory = new BulletFactory(mGame);
			for (var i:int = 0; i < 10; i++)
			{
				var bullet:Bullet = factory.createSimpleBullet();
				bullet.Owner = i % 2;
				Manager.addBullet(bullet);
			}			
			
			
			var count:int = Manager.getActiveBullets().length;
			count = count;
		}
		
		public function deletion():void
		{
			
			var toDel:Bullet = new Bullet(mGame, 0, 0, new Point(0, 0));
			toDel.Owner = 50;
			
			Manager.addBullet(toDel);
			var count:int = Manager.getActiveBullets().length;
			
			Manager.removeBullet(toDel);
			count = Manager.getActiveBullets().length;
			
			testDeleteDeadBullets();
			
			//Manager.removeAllBullets();
			
			count = Manager.getActiveBullets().length;
			
			count = count;
		}
		
		private function testDeleteDeadBullets():void
		{
			var factory:BulletFactory = new BulletFactory(mGame);
			var bull:Bullet = factory.createSimpleBullet();
			var bullAfter:Bullet = factory.createSimpleBullet();
			bullAfter.Owner = 333;
			
			bull.LifeTime = -1;
			bull.Owner = 111;
			
			Manager.addBullet(bull);
			Manager.addBullet(bullAfter);
			var count:int = Manager.getActiveBullets().length;
			Manager.removeInactiveBullets();
			count = Manager.getActiveBullets().length;
			
			count = count;
		}
		
		public function handleInput():void
		{
			if (FlxG.keys.justPressed("SPACE"))
			{
				var bullFac:BulletFactory = new BulletFactory(mGame);
				var bullet:Bullet = bullFac.createBulletFromCharacter(mGame.ActivePlayer(), 2.0, 50.0);
 				mGame.getBulletMgr().addBullet(bullet);
			}
		}
		
		public function testUpdate():void 
		{
			Manager.removeInactiveBullets();
			mGame.getBulletMgr().removeInactiveBullets();
		}
		
		public function testDraw():void
		{
			
		}
	}

}