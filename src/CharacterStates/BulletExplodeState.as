package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BulletExplodeState extends CharacterState 
	{
		public static var STATE_ID:int = 5439062;
		var mBullet:Bullet;
		public function BulletExplodeState(bullet:Bullet) 
		{
			super(STATE_ID, bullet);
			mBullet = bullet;
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			mBullet.ChangeAnimation("explode");
			mBullet.LifeTime = 1;
			mBullet.mGame.PlaySoundEffect("bullet_hit_wall",2.0);
		}
		
		override public function OnUpdate():void 
		{
			if (mBullet.finished)
			{
				mBullet.active = false;
				mBullet.LifeTime = -1;
			}
		}
		
	}

}