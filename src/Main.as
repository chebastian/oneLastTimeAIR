package {
	import org.flixel.*;
	import org.flixel.FlxState;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		static var LAYER_BKG:FlxGroup = new FlxGroup();
		public function Main():void
		{
			super(640, 480, MenuState, 5);
			//useDefaultHotKeys = true;
		}
	}
}
