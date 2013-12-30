package Particles 
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.CameraPosition;
	import flash.utils.Timer;
	import org.flixel.FlxGroup;
	import Tests.BeamSwitchTest;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Emitter extends FlxGroup
	{
		
		var particles:FlxGroup;
		var mTimer:Timer;
		var mParticleBase:Particle;
		var mParticleLifeTime:Number;
		var mFireDirection:Point;
		var mFireSpeed:Number;
		var mFireRate:Number;
		var mPosition:Point;
		var mActive:Boolean;
		
		public function Emitter(pos:Point) 
		{
			particles = new FlxGroup();
			mPosition = pos.clone();
			mActive = false;
		}
		
		public function init(fireRate:Number,lifeTime:Number,particleBase:Particle):void
		{
			mFireRate = fireRate;
			mTimer = new Timer(fireRate, 0);
			mTimer.addEventListener(TimerEvent.TIMER, onTimerReached);
			mParticleBase = particleBase;
			mParticleLifeTime = lifeTime;
			mFireSpeed = 100;
			mFireDirection = new Point(0,mFireSpeed);
		}
		
		public function setActive(a:Boolean):void
		{
			if (a)
			{
				mTimer.start();
			}
			else
			{
				for each(var e:Particle in this.members)
					e.kill();
					
				mTimer.stop();
			}
				
			mActive = a;
		}
		
		public function onTimerReached(evt:TimerEvent):void
		{
			var p:Particle = createNewParticleFromEmitter();
			addNewParticle(p);
		}
		
		public function createNewParticleFromEmitter():Particle
		{
			var p:Particle = mParticleBase.copyOf();
			p.x = mPosition.x;
			p.y = mPosition.y;
			p.Init();
			p.initAnimations();
			p.velocity.x = mFireDirection.x * mFireSpeed;
			p.velocity.y = mFireDirection.y * mFireSpeed;
			return p;
		}
		
		public function addNewParticle(p:Particle):void
		{
			add(p);
			//particles.add(p);
		}
		
		override public function update():void 
		{
			if (!mActive)
				return;
				
			super.update();
			for each(var e:Particle in this.members)
			{
				if (e.getLifeTime() > getParticleLifeTime())
					e.kill();
			}
		}
		
		override public function draw():void 
		{
			if(mActive)
				super.draw();
		}
		
		public function getParticleLifeTime():Number
		{
			return mParticleLifeTime;
		}
		
		public function getParticles():FlxGroup
		{
			return this;
		}
		
		public function setPosition(pos:Point):void
		{
			mPosition = pos.clone();
		}
	}

}