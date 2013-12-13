package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class TestState extends FlxState
	{
		
		public function TestState() 
		{
			add(new FlxText(FlxG.width * 0.3, FlxG.height * 0.3, 200, "now your in test"));
		}
		
	}

}