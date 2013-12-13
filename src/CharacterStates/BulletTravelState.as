package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	
	 import org.flixel.*;
	 
	public class BulletTravelState extends CharacterState 
	{
		var mBullet:Bullet;
		public function BulletTravelState(bullet:Bullet) 
		{
			super(999943, bullet);
			mBullet = bullet;
		}
		
		
		override public function OnUpdate():void 
		{
			mBullet.updateLifeTime();
			mBullet.updatePosition();
			
			if (mBullet.justTouched(FlxObject.RIGHT | FlxObject.LEFT  | FlxObject.UP | FlxObject.DOWN))
			{
				mCharacter.ChangeState(new BulletExplodeState(mBullet));
			}
			
			if (mBullet.isTimeToDie())
				mCharacter.ChangeState(new BulletExplodeState(mBullet));
		}
		
		override public function OnEnter(game:PlayState):void 
		{
			super.OnEnter(game);
			game.PlaySoundEffect(mBullet.getFireSoundEffect());
			mBullet.ChangeAnimation("fire");
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
		
	}

}