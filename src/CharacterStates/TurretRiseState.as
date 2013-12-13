package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class TurretRiseState extends CharacterState 
	{
		
		var mTurret:EnemyTurret;
		var mGame:PlayState;
		var mTimeSinceFire:Number;
		
		public function TurretRiseState(turret:EnemyTurret) 
		{
			mId = 1239875431;
			super(mId, turret);
			mTurret = turret;
		}
		
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			mTurret.changeAnimationBasedOnHeading();
			mTurret.ChangeAnimation("rise",null,true);
			mGame = game;
			mTimeSinceFire = 0.0;
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			if (mTurret.finished && !mTurret.canSeeCharacter(mGame.ActivePlayer()))
				mTurret.ChangeState(new TurretLowerState(mTurret));
				
			if (mTurret.finished && mTurret.canSeeCharacter(mGame.ActivePlayer()) && mTurret.getWeapon().canFire())
			{
				var factory:BulletFactory = new BulletFactory(mGame);
				var bull:Bullet  = factory.createBulletFromCharacterWeapon(mTurret);
				mGame.getBulletMgr().addBullet(bull);
			}
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
			mTurret.ChangeAnimation("lower");
		}
		
	}

}