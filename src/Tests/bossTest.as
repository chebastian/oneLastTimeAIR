package Tests 
{
	import CharacterStates.WalkerChargeState;
	import flash.geom.Point;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class bossTest 
	{
		var mEnemy:EnemyBossman;
		var mGame:PlayState;
		public function bossTest(game:PlayState) 
		{
			mEnemy = new EnemyBossman(game, new Point(19, 10));
			mEnemy.Init();
			mEnemy.InitAnimations();
			mGame = game;
			mEnemy.setHeading(new Point(0, 1));
		}
		
		public function initTest():void
		{
			mGame.LAYER_TEST.add(mEnemy);
		}
		
		public function updateTest():void
		{
			mEnemy.StopMoving();
			if (FlxG.keys.justPressed("A"))
			{
				mEnemy.ChangeState(new WalkerChargeState(mEnemy));
			}
			if (FlxG.keys.justPressed("S"))
			{
				mEnemy.ChangeAnimation("walkR");
			}
			if (FlxG.keys.justPressed("D"))
			{
				mEnemy.ChangeAnimation("idle");
			}
		}
		
	}

}