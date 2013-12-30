package Particles 
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class CirclePulseEmitter extends Emitter 
	{
		
		var mTotalTime:Number;
		var mResolution:uint;
		var mCurrentNum:uint;
		
		public function CirclePulseEmitter(pos:Point) 
		{
			super(pos);
			mTotalTime = 0.0;
			mResolution = 9;
			mCurrentNum = 1;
			this.maxSize = 20;
		}
		
		override public function init(fireRate:Number, lifeTime:Number, particleBase:Particle):void 
		{
			super.init(fireRate, lifeTime, particleBase);
			mTotalTime = 0.0;
			mFireSpeed = 20;
		}
		
		override public function onTimerReached(evt:TimerEvent):void 
		{
			/*updateFireDirection();
			super.onTimerReached(evt);
			
			updateFireDirection();
			super.onTimerReached(evt);*/
			addParticlesToCircle(mResolution);
			mTotalTime += mFireRate/1000.0;
			if (mTotalTime >= 1)
				mTotalTime = 0.0;
		}
		
		protected function addParticlesToCircle(resolution:uint)
		{
			for (var i:uint = 1; i <= resolution; i++)
			{
				updateFireDirection(i, resolution);
				addNewParticle(createNewParticleFromEmitter());
			}
		}
		
		override public function createNewParticleFromEmitter():Particle 
		{
			var p:Particle = mParticleBase.copyOf();
			p.x = mPosition.x + (mFireDirection.x * mFireSpeed/2);
			p.y = mPosition.y + (mFireDirection.y * mFireSpeed/2);
			p.Init();
			p.initAnimations();
			p.velocity.x = mFireDirection.x * -mFireSpeed;
			p.velocity.y = mFireDirection.y * -mFireSpeed;
			return p;
		}
		
		protected function updateFireDirection(num:uint,res:uint):void
		{
			mFireDirection.x = (Math.sin((num/res)* (Math.PI*2)))*mTotalTime;
			mFireDirection.y = (Math.cos((num/res)* (Math.PI*2)))*mTotalTime;
		}
	}

}