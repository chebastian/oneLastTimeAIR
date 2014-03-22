package CharacterController 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyBossController extends CharacterController 
	{
		var mTurnCounter:uint;
		var mMaxTurns:uint;
		var mCurrentDir:Point;
		public function EnemyBossController(char:Character, game:PlayState) 
		{
			super(char, game);
			mMaxTurns = 3;
			mTurnCounter = 0;
			mCharacter.setHeading(new Point(1, 0));
			mCurrentDir = new Point(1, 0);
			mCharacter.WalkInDir(mCurrentDir);
		}
		
		override public function update():void 
		{
			super.update();
			mCharacter.WalkInDir(mCurrentDir);
			if (mCharacter.JustHitWall())
			{
					mCurrentDir.x *= -1;
			}
		}
		
	}

}