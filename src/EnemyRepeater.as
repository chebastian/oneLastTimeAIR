package  
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyRepeater extends EnemyTurret 
	{
		
		public function EnemyRepeater(game:PlayState, pos:Point) 
		{
			super(game, pos);
			width = 1;
			height = 1;
			mAABBHeightOffset = 0;
			mAABBWidthOffset = 0;
		}
		
		override public function Init():void 
		{
			super.Init();
			mAnimationsPath = "./media/enemy/repeater/repeater_anims.txt";
			mCurrentWeapon = new Weapon(mGame, 1.0, 100, 0.5);
		}
		
		override public function changeAnimationBasedOnHeading():void 
		{
			if (getLookAt().x < 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("repeaterLeft"));
			else if(getLookAt().x > 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("repeaterRight"));
			else if (getLookAt().y > 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("repeaterDown"));
			else if (getLookAt().y < 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("repeaterUp"));
		}
		override public function canSeeCharacter(char:Character):Boolean 
		{
			return true;
		}
	}

}