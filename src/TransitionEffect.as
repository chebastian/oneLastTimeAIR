package  
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import PlayState;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class TransitionEffect extends EventDispatcher
	{
		protected var mDone:Boolean;
		protected var mTime:Number;
		protected var mSW:int;
		protected var mSH:int;
		protected var mGame:PlayState;
		protected var mTimer:Timer;
		protected var mCountDown:Timer;
		
		public function TransitionEffect(game:PlayState) 
		{
			mGame = game;
		}
		
		public function init(numw:int, numh:int, time:Number)
		{
				mSW = numw; mSH = numh;
				mTime = time;
				mDone = false;
				mTimer = new Timer(time, 1);
				mCountDown = new Timer(2, 0);
				
				//mCountDown.addEventListener(TimerEvent.TIMER, OnUpdate);
				
				//mTimer.start();
				//mCountDown.start();
				FlxG.fade(0xff000000, time, OnDone);
		}
		
		public function OnUpdate(e:Event)
		{
				trace("####### FADER UPDATE #######");
		}
		
		public function OnDone(e:Event):void
		{
			dispatchEvent(new Event("Fade Complete"));
			mCountDown = null;
			mDone = true;
		}
		
		public function Done():Boolean
		{
			return mDone;
		}
		
	}

}