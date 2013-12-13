package CharacterStates 
{
	import com.adobe.air.filesystem.events.FileMonitorEvent;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class CharacterWalking extends CharacterState 
	{
		
		public function CharacterWalking(char:Character) 
		{
			super(CHARACTER_WALKING_STATE, char);
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			changeAnimBasedOnHeading();
		}
		
		protected function changeAnimBasedOnHeading():void
		{
			var anim:String = mCharacter.getAnimationBasedOnLookAt(mCharacter.Animation_WalkLeft, mCharacter.Animation_WalkRight,
												mCharacter.Animation_WalkUp, mCharacter.Animation_WalkDown);
			mCharacter.ChangeAnimation(anim);
		}
		
	}

}