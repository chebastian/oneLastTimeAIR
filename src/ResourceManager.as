package  
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class ResourceManager 
	{
		
		var mGame:PlayState;
		var mAnimationBanks:FlxGroup;
		
		public function ResourceManager(game:PlayState) 
		{
			mAnimationBanks = new FlxGroup();
		}
		
		public function getAnimationBank(file:String):AnimationBank
		{
			var bank:AnimationBank = new AnimationBank();
			
			for (var anim:AnimationBank in mAnimationBanks.members)
			{
				if(anim.Path == file)
					return anim;
			}
			
			return bank;
			
		}
		
		
		
	}

}