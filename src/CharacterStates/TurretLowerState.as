package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class TurretLowerState extends CharacterState 
	{
		
		var mTurret:EnemyTurret;
		var mGame:PlayState;
		public function TurretLowerState(char:EnemyTurret) 
		{
			mId = 5437843000;
			super(mId, char);
			mTurret = char;
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			mTurret.changeAnimationBasedOnHeading();
			mTurret.ChangeAnimation("lower",null,true);
			mGame = game;
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			if (mTurret.canSeeCharacter(mGame.ActivePlayer()))
				mTurret.ChangeState(new TurretRiseState(mTurret));
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}