package CharacterStates 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class DamagedState extends CharacterState 
	{
		
		var mDamageCooldown:Number = 1.0;
		public function DamagedState(char:Character) 
		{
			super(DAMAGED_STATE, char);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			trace("DAMAGER");
			mStateTimer = 0.0;
			changeAnimBasedOnDir();
			mCharacter.WalkInDir(new Point(0, 0));
		}	
		
		public function changeAnimBasedOnDir():void
		{
			if(mCharacter.Heading().x > 0)
				mCharacter.ChangeAnimation(mCharacter.Animation_DamagedR,null,true);
			else if (mCharacter.Heading().x < 0)
				mCharacter.ChangeAnimation(mCharacter.Animation_DamagedL,null,true);
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			
			if (mCharacter.finished)
				mCharacter.ChangeState(new WanderState(mCharacter));
		}
		
	}

}