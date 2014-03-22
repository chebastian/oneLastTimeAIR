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
		var mActive:Boolean;
		public function bossTest(game:PlayState, active:Boolean) 
		{
			mActive = active;
			if (!mActive)
				return;
			
			mEnemy = new EnemyBossman(game, new Point(19, 20));
			mEnemy.Init();
			mEnemy.InitAnimations();
			mGame = game;
			mEnemy.setHeading(new Point(0, 1));
			mGame.ActiveLevel().ActiveRoom().addEnemyToRoom(mEnemy);
		}
		
		public function initTest():void
		{
			
		}
		
		public function updateTest():void
		{
			if (!mActive)
				return;
				
			mEnemy.StopMoving();
			if (FlxG.keys.justPressed("A"))
			{
				mEnemy.PushState(new WalkerChargeState(mEnemy));
			}
			if (FlxG.keys.justPressed("S"))
			{
				mEnemy.ChangeAnimation("walkR");
			}
			if (FlxG.keys.justPressed("D"))
			{
				mEnemy.ChangeAnimation("walkL");
			}
		}
		
	}

}