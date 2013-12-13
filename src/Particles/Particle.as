package Particles 
{
	import flash.events.Event;
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
		public function Particle(game:PlayState, _x:Number, _y:Number,animations:String) 
		{
			super(_x, _y, null);
			mGame = game;
			mAnimationsPath = animations;
			mAnimationsLoader = new AnimationLoader(mGame);
			mAnimations = new AnimationBank();
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
			mAnimations.playAnimation("fire", this);
		}
		
		
	}

}