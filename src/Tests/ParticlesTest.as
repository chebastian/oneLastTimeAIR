package Tests 
{
	import com.adobe.air.filesystem.events.FileMonitorEvent;
	import flash.geom.Point;
	import org.flixel.FlxEmitter;
	import Particles.CirclePulseEmitter;
	import Particles.Emitter;
	import Particles.Particle;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class ParticlesTest 
	{
		var mGame:PlayState;
		var mParticle:Particle;
		var mEmitter:Emitter;
		
		public function ParticlesTest(game:PlayState) 
		{
			mGame = game;
			mParticle  = new Particle(mGame, 20, 20, "./media/particles/particle_animations.txt");
			mParticle.Init();
			mParticle.initAnimations();
			//mGame.LAYER_TEST.add(mParticle);
			
			mEmitter = new CirclePulseEmitter(new Point(30,30));
			mEmitter.init(300, 0.5, mParticle);
			mEmitter.setActive(true);
			mGame.LAYER_TEST.add(mEmitter.getParticles());
		}
		
		public function initTest():void
		{
			
		}
		
	}

}