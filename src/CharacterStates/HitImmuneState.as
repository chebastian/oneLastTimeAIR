package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class HitImmuneState extends CharacterState 
	{
		
		public function HitImmuneState(char:Character) 
		{
			mId = 6;
			super(mId, char);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			changeAnimBasedOnHeading();
		}
		
		public function changeAnimBasedOnHeading():void
		{
			if (mCharacter.getLookAt().x < 0)
				mCharacter.ChangeAnimationForced("immuneR");
			else 
				mCharacter.ChangeAnimationForced("immuneL");
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			if (mCharacter.finished)
				mCharacter.ChangeState(new WanderState(mCharacter));
		}
		
	}

}