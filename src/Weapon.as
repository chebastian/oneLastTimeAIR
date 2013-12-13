package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Weapon 
	{
		
		protected var mFireRate:Number;
		protected var mFireLength:Number;
		protected var mFireSpeed:Number;
		protected var mGame:PlayState;
		protected var mLastTime:Number;
		protected var mBulletSrc:String;
		protected var mBulletPrototype:Bullet;
		
		public function Weapon(game:PlayState, fireRate:Number, speed:Number, length:Number) 
		{
			mGame = game;
			mFireLength = length;
			mFireSpeed = speed;
			mFireRate = fireRate;
			mLastTime = 0.0;
			mBulletSrc = "./media/player/bullet/bullet_anims.txt";
		}
		
		public function setBulletPrototype(bul:Bullet):void
		{
			mBulletPrototype = bul.clone();
		}
		
		
		public function getBulletSrc():String
		{
			return mBulletSrc;
		}
		
		public function setBulletStr(src:String):void {
			mBulletSrc = src;
		}
		public function getFireRate():Number
		{
			return mFireRate;
		}
		
		public function getFireRateInMilliseconds():Number
		{
			return mFireRate * 1000.0;
		}
		
		public function getFireLength():Number
		{
			return mFireLength;
		}
		
		public function getBulletSpeed():Number
		{
			return mFireSpeed;
		}
		
		public function canFire():Boolean
		{
			var date:Date = new Date();
			var delta:Number = date.time - mLastTime;
			
			if (delta >= getFireRateInMilliseconds())
			{
				mLastTime = date.time;
				return true;
			}
			
			return false;
		}
		public function createBullet():Bullet 
		{
			var factory:BulletFactory = new BulletFactory(mGame);
			var bullet:Bullet = factory.createSimpleBullet();
			bullet.SetSpeed(mFireSpeed);
			bullet.LifeTime = mFireLength;
			return bullet;
		}
		
		public function createBulletFromPrototype():Bullet
		{
			return mBulletPrototype.clone();
		}
	}

}