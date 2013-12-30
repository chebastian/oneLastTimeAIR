package Particles 
{
	import flash.events.Event;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Particle extends GameObject
	{
		var mGame:PlayState;
		var mAnimationsLoader:AnimationLoader;
		var mAnimations:AnimationBank;
		var mAnimationsPath:String;
		var mLifeTime:Number;
		
		public function Particle(game:PlayState, _x:Number, _y:Number,animations:String) 
		{
			super(_x, _y, null);
			mGame = game;
			mAnimationsPath = animations;
			mAnimationsLoader = new AnimationLoader(mGame);
			mAnimations = new AnimationBank();
			mLifeTime = 0;
		}
		
		public function copyOf():Particle
		{
			var p:Particle = new Particle(mGame, x, y, mAnimationsPath);
			return p;
		}
		
		override public function Init():void 
		{
			super.Init();
		}
		
		public virtual function initAnimations():void
		{
			mAnimationsLoader.addEventListener(Event.COMPLETE, onAnimationsLoaded);
			mAnimationsLoader.loadBankFromFile(mAnimationsPath);
		}
		
		public function onAnimationsLoaded(e:Event):void
		{
			mAnimations = mAnimationsLoader.getAnimationBank();
			mAnimations.registerAnimationsToSprite(this);
			mAnimations.playAnimation("pulse", this);
		}
		
		override public function update():void 
		{
			super.update();
			mLifeTime += FlxG.elapsed;
		}
		
		public function getLifeTime():Number
		{
			return mLifeTime;
		}
		
	}

}