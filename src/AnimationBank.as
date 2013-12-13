package  
{
	import flash.utils.SetIntervalTimer;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class AnimationBank 
	{
		var mAnimations:Array;
		var Path:String;
		private var LoadComplete:Boolean;
		var mCurrentImg:Class;
		
		public function AnimationBank() 
		{
			Path = new String("Not Loaded");
			mAnimations = new Array();
			LoadComplete = false;
			mCurrentImg = null;
		}
		
		public function changeCurrentBase(img:Class):void
		{
			mCurrentImg = img;
		}
		
		public function addAnimation(clip:AnimationClip)
		{
			mAnimations.push(clip);
		}
		
		public function containsClip(name:String):Boolean
		{
			for (var i:uint = 0; i < mAnimations.length; i++)
			{
				if (mAnimations[i].name == name)
					return true;
			}
			
			return false;
		}
		
		public function getAnimationFromImg(img:Class, name:String):AnimationClip
		{
			for each(var anim:AnimationClip in mAnimations)
			{
				if (anim.src == img && anim.name == name)
					return anim;
			}
			
			return null;
		}
		
		public function getAnimation(name:String):AnimationClip
		{
			if (mCurrentImg != null)
				return getAnimationFromImg(mCurrentImg, name);
				
			for (var i:uint = 0; i < mAnimations.length; i++)
			{
				if (mAnimations[i].name == name)
					return mAnimations[i];
			}
			
			return null;
		}
		
		
		public function registerAnimationsToSprite(spr:FlxSprite)
		{
			for (var i:int = 0; i < mAnimations.length; i++)
			{
				var anim:AnimationClip = mAnimations[i];
				spr.addAnimation(anim.name, anim.frames, anim.fps, anim.looped);
			}
			
			LoadComplete = true;
		}
		
		public function isFinishedLoading():Boolean
		{
			return LoadComplete;
		}
		
		public function playAnimation(name:String,char:FlxSprite)
		{
			for each(var anim:AnimationClip in mAnimations)
			{
				if (anim.name == name)
				{
					char.loadGraphic(anim.src, true, false, anim.fw, anim.fh, false);
					char.play(anim.name);
				}
			}
		}
	}

}