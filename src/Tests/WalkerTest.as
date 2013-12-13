package Tests 
{
	import CharacterStates.AttackState;
	import flash.geom.Point;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class WalkerTest 
	{
		var walker:EnemyWalker;
		var mGame:PlayState;
		public function WalkerTest(game:PlayState) 
		{
			mGame = game;
			walker = new EnemyWalker(mGame, new Point(40, 20));
		}
		
		
		
		public function initTest():void
		{
			walker.Init();
			mGame.ActiveLevel().ActiveRoom().addEnemyToRoom(walker);
		}
		
		
		public function testUpdate():void 
		{
			//FlxG.collide(walker, mGame.ActiveLevel().ActiveRoom().MapCollisionData());
			
			if (FlxG.keys.justPressed("K"))
			{
				var factory:BulletFactory = new BulletFactory(mGame);
				var bull:Bullet = factory.createBulletFromCharacter(walker, 1.0, 50);
				mGame.getBulletMgr().addBullet(bull);
			}
		}
		
		public function getWalker():Enemy
		{
			return walker;
		}
		
	}

}