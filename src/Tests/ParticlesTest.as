package Tests 
{
	import com.adobe.air.filesystem.events.FileMonitorEvent;
	import org.flixel.FlxEmitter;
	import Particles.Particle;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class ParticlesTest 
	{
		var mGame:PlayState;
		var mParticle:Particle;
		
		public function ParticlesTest(game:PlayState) 
		{
			mGame = game;
			mParticle  = new Particle(mGame, 20, 20, "./media/player/bullet/bullet_anims.txt");
			mParticle.Init();
			mParticle.initAnimations();
			mGame.LAYER_TEST.add(mParticle);
		}
		
		public function initTest():void
		{
			
		}
		
	}

}