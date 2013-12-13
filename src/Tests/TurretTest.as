package Tests 
{
	import flash.geom.Point;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class TurretTest 
	{
		var mGame:PlayState;
		var mTurret:EnemyTurret;
		var t:EnemyWalker;
		var weapon:Weapon;
		
		public function TurretTest(game:PlayState) 
		{
			mGame = game;
			mTurret = new EnemyTurret(mGame, new Point(24, 60));
			weapon = new Weapon(mGame, 1.0 / 3.0, 50, 0.5);
		}
		
		public function inti():void
		{
			//mGame.LAYER_ENEMY.add(mTurret);
			mTurret.Init();
			mGame.ActiveLevel().ActiveRoom().addEnemyToRoom(mTurret);
		}
		
		public function udpate():void 
		{
			if (FlxG.keys.justPressed("D"))
				{
					if (weapon.canFire())
						trace("FIRE");
				}
				
			
		}
		
	}

}