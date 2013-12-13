package CharacterStates 
{
	/**
	 * ...
	 * @author ...
	 */
	public class SlimeAttackState extends CharacterState 
	{
		var mAttackWalkSpeed:Number;
		
		public function SlimeAttackState(id:uint, char:Character) 
		{
			super(id, char);
			mAttackWalkSpeed = mCharacter.Speed() + 30;
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			mCharacter.SetSpeed(mAttackWalkSpeed);
			mCharacter.WalkInDir(mCharacter.Heading());
		}
		
	}

}