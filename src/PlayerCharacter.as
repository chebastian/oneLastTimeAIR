package  
{
	import CharacterStates.AttackState;
	import CharacterStates.DeathState;
	import CharacterStates.PlayerDeathState;
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author ...
	 */
	
	 import org.flixel.FlxG;
	 
	public class PlayerCharacter extends Character
	{
		public function PlayerCharacter(game:PlayState,pos:Point) 
		{
			super(game, pos.x, pos.y);
			this.scale = new FlxPoint (2, 2);
		}
		
		override public function Init():void 
		{
			super.Init();
			mStrength = 50.0;
		}
		
		override public function InitAnimations():void 
		{
			super.InitAnimations();
			//addAnimation("attack",[8,8], 2,true);
		}
		
		override public function update():void 
		{
			super.update();
				
			//HandleInput();
		}
		
		public function killPlayer():void
		{
			//ChangeState(new PlayerDeathState(this));
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			return super.OnHitCharacter(char);
		}
		
		public function HasKeys():Boolean
		 {
			 return mGame.Keys > 0;
		 }
		 
		 public function UseKey():void
		 {
			 mGame.Keys--;
		 }
		
	}

}