package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class TurretIdleState extends CharacterState 
	{
		var mTurret:EnemyTurret;
		var mGame:PlayState;
		public function TurretIdleState(turret:EnemyTurret) 
		{
			mId = 9;
			super(mId, turret);
			
			mTurret = turret;
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			mGame = game;
			mTurret.ChangeAnimation("idleDown");
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			if (mTurret.canSeeCharacter(mGame.ActivePlayer()))
			{
				mTurret.ChangeState(new TurretRiseState(mTurret));
			}
		}
		
		
	}

}