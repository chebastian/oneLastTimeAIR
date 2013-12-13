package  
{
	/**
	 * ...
	 * @author ...
	 */
	import air.update.descriptors.StateDescriptor;
	import Character;
	import org.flixel.FlxG;
	
	public class CharacterState 
	{
		protected var mCharacter:Character;
		protected var mId:uint;
		protected var mStateTimer:Number;
		
		public static var IDLE_STATE:uint = 0;
		public static var ATTACK_STATE:uint = 1;
		public static var WANDER_STATE:uint = 2;
		public static var DAMAGED_STATE:uint = 3;
		public static var DEATH_STATE:uint = 4;
		public static var PLAYER_DEATH_STATE:uint = 5;
		
		public static var JUMPING_STATE:uint = 61;
		public static var JUMPER_IDLESTATE:uint = 62;
		
		public static var CHARACTER_WALKING_STATE:uint = 90;
		public static var CHARACTER_SPAWN_STATE:uint = 100;
		public function CharacterState(id:uint, char:Character) 
		{
			mId = id; mCharacter = char;
			mStateTimer = 0;
		}
		
		public virtual function StateId():uint
		{
			return mId;
		}
		
		public function OnEnter(game:PlayState):void {
			mStateTimer = 0;
		}
		
		public function OnUpdate():void {
			mStateTimer += FlxG.elapsed;
		}
		
		public function OnExit():void {
			
		}
		
		public virtual function onHit(obj:GameObject)
		{
		}
		
	}

}