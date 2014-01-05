package CharacterStates 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class WalkerChargeState extends CharacterState 
	{
		public static var WALKER_STATEID:int = 54324238;
		public function WalkerChargeState(char:Character) 
		{
			super(WALKER_STATEID, char);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			setAnimBasedOnHeading();
			mCharacter.StopMoving();
			mCharacter.mGame.PlaySoundEffect("enemy_charge");
		}
		
		protected function setAnimBasedOnHeading():void
		{
			if (mCharacter.Heading().x < 0)
				mCharacter.ChangeAnimationForced(mCharacter.Animation_Attack_L);
			else 
				mCharacter.ChangeAnimationForced(mCharacter.Animation_Attack_R)
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			mCharacter.StopMoving();
			if (mCharacter.finished)
			{
				
				fireBullet();
				//mCharacter.ChangeState(new WanderState(mCharacter));
				mCharacter.PopState();
			}
		}
		
		protected function fireBullet():void
		{
			var factory:BulletFactory = new BulletFactory(mCharacter.mGame);
			var bull:Bullet = factory.createBulletFromCharacter(mCharacter, 1.0, 50);
			var dir:Point = mCharacter.getLookAt().clone();
			bull.setDir(new Point(dir.x,dir.y));
			mCharacter.mGame.getBulletMgr().addBullet(bull);
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}