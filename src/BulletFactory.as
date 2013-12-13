package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BulletFactory 
	{
		var mGame:PlayState;
		public function BulletFactory(game:PlayState) 
		{
			mGame = game;
		}
		
		public function setupBulletByCharacter(char:Character, bullet:Bullet):Bullet
		{
			var x:int = new int(char.getBulletOrigin().x);
			var y:int = new int(char.getBulletOrigin().y);
			
			bullet.setPosition(new Point(x, y));
			bullet.setDir(char.Heading().clone());

			bullet.Init();
			bullet.SetSpeed(char.getWeapon().getBulletSpeed());
			//bullet.velocity.x = new Number(char.getLookAt().x);
			//bullet.velocity.y = new Number(char.getLookAt().y);
			bullet.Owner = char.GetUniqueId();

			bullet.InitAnimations();
			
			return bullet;
		}
		
		public function createBulletFromCharacter(char:Character, lifeTime:Number, speed:Number):Bullet
		{
			//var bullet = createSimpleBullet();
			var x:int = new int(char.getBulletOrigin().x);
			var y:int = new int(char.getBulletOrigin().y);
			
			var bullet:Bullet = new Bullet(mGame, x, y, new Point(char.getLookAt().x, char.getLookAt().y));
			bullet.setAnimationSrc(char.getWeapon().getBulletSrc());

			bullet.Init();
			bullet.SetSpeed(speed);
			//bullet.velocity.x = new Number(char.getLookAt().x);
			//bullet.velocity.y = new Number(char.getLookAt().y);
			bullet.LifeTime = lifeTime;
			bullet.Owner = char.GetUniqueId();

			bullet.InitAnimations();
			
			return bullet;
		}
		
		public function createBulletFromCharacterWeapon(char:Character):Bullet
		{
			var bullet = this.createBulletFromCharacter(char, char.getWeapon().getFireLength(), char.getWeapon().getBulletSpeed());
			return bullet;
		}
		
		public function createRayFromCharacter(char:Character, lifeTime:Number, speed:Number):BulletRay
		{
			var x:int = new int(char.getBulletOrigin().x);
			var y:int = new int(char.getBulletOrigin().y);
			
			var bullet:BulletRay = new BulletRay(mGame, x, y, new Point(char.Heading().x, char.Heading().y));
			bullet.SetSpeed(speed);
			bullet.velocity.x = new Number(char.getLookAt().x);
			bullet.velocity.y = new Number(char.getLookAt().y);
			bullet.LifeTime = lifeTime;

			bullet.InitAnimations();
			
			return bullet;
		}
		
		public function createSimpleBullet():Bullet
		{
			var bullet:Bullet = new Bullet(mGame, 0, 0, new Point(0, 0));
			return bullet;
		}
		
	}

}