package Tests 
{
	import flash.display.FocusDirection;
	import flash.geom.Point;
	import RoomAssets.SwitchBeam;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BeamSwitchTest
	{
		var mBeam:SwitchBeam;
		var mGame:PlayState;
		public function BeamSwitchTest(game:PlayState) 
		{
			mBeam = new SwitchBeam(game, 24, 24);
			mGame = game;
			mBeam.Init();
			mBeam.InitAnimations();
		}
		
		public function init():void
		{
			//mGame.ActiveLevel().ActiveRoom().AddGameObjects(mBeam);
			mGame.ActiveLevel().ActiveRoom().AddGameObjects(mBeam);
			//mGame.LAYER_TEST.add(mBeam);
			mBeam.ChangeAnimation("beamLeft");
		}
		
		
	}

}