package  
{
	import air.update.descriptors.ConfigurationDescriptor;
	import com.adobe.air.logging.FileTarget;
	import flash.accessibility.AccessibilityProperties;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import org.flixel.FlxCamera;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import LevelMap;
	import org.flixel.FlxTileblock;
	import org.flixel.system.FlxList;
	import Tests.BeamSwitchTest;
	import Tests.ParticlesTest;
	import Tests.TurretTest;
	import Tests.WalkerTest;
	import TransitionEffect;
	import Character;
	import CellRoom;
	import Tests.DynamicLevelLoaderTest;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PlayState extends FlxState
	{
		protected var mLevelMap:LevelMap;
		//protected var mLevel:CellRoom;
		protected var mDoneLoadingString:String;
		protected var mCellLevel:CellLevel;
		//var mTransEffect:TransitionEffect;
		var mCamera:FlxCamera;
		
		var mPlayer:PlayerCharacter;
		var mSlime:EnemySlime;
		var mActivePortal:CellLevelPortal;
		
		public var LAYER_BKG:FlxGroup;
		public var LAYER_BKG1:FlxGroup;
		public var LAYER_MID:FlxGroup;
		public var LAYER_ITEM:FlxGroup;
		public var LAYER_ENEMY:FlxGroup;
		public var LAYER_FRONT:FlxGroup;
		public var LAYER_TEST:FlxGroup;
		
		public var PlayerCurrentItems:FlxGroup;
		public var Keys:uint;
		public static var TILE_WIDTH:int = 8;
		public static var TILE_HEIGHT:int = 8;
		
		
		private var mBulletMgr:BulletManager;
		private var mBulletTest:BulletTest;
		
		private var mWalkerTest:WalkerTest;
		private var mTurretTest:TurretTest;
		private var mBeamTest:BeamSwitchTest;
		
		private var mResources:GameResources;
		private var mLevelToLoad:String;
		private var mLevelTest:DynamicLevelLoaderTest;
		private var mEmitterTest:ParticlesTest;
		
		public function PlayState(str:String) 
		{
			super();
			mLevelToLoad = str;
		}
		
		override public function create():void 
		{
			super.create();
			
			var readFile:FolderScanTest = new FolderScanTest();
			readFile.intitTest();
			
			mResources = new GameResources();
			mResources.initResources();
			mResources.preLoadAnimations(this);
			
			FlxG.debug = true;
			//testCamera();
			CreateLayers();
			
			mDoneLoadingString = "NOT DONE LOADING";
			
			//mTransEffect = new TransitionEffect(this);
			//mTransEffect.init(20, 20, 5);
			//mTransEffect.addEventListener("Fade Complete", FadeComplete);
			mPlayer = new PirateCharacter(this, new Point(30, 30));
			mPlayer.Init();
			mPlayer.InitAnimations();
			PlayerCurrentItems = new FlxGroup();
			
			mBulletMgr = new BulletManager(this);
			
			LAYER_ENEMY.add(mPlayer);
			mCellLevel = new CellLevel(this);
			//mCellLevel.LoadLevel("../media/levels/wip/wip.xml");
			mCellLevel.LoadLevel(mLevelToLoad);
			//mCellLevel.LoadLevel("./media/Levels/entTest/entTest.xml");
			
//			mBulletTest = new BulletTest(this);
			mWalkerTest = new WalkerTest(this);
		//	mWalkerTest.initTest();
			mTurretTest = new TurretTest(this);
			
			mBeamTest = new BeamSwitchTest(this);
			
			mLevelTest = new DynamicLevelLoaderTest(this);
			
			mEmitterTest = new ParticlesTest(this);
			mEmitterTest.initTest();
			
		}
		
		public function testCamera():void {
			var cam:FlxCamera = new FlxCamera(50, 0, FlxG.camera.width, FlxG.camera.height, 2);
			cam.x = 50;
			cam.y = 50;
			mCamera = cam;
			FlxG.addCamera(mCamera);
			FlxG.camera.follow(mPlayer);
		}
		
		public function testUpdateCam():void
		{
			FlxG.camera.x = 50;
			FlxG.camera.y = 50;
			FlxG.camera.update();
		}
		
		public function TestPHP():void
		{
			var request:URLRequest = new URLRequest("../src/php_scripts/hello.php");
			var variables:URLVariables = new URLVariables();

			variables.score = String(Math.floor(Math.random()*10));

			request.data = variables;
			request.method = URLRequestMethod.POST ;

			var loader:URLLoader = new URLLoader();
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, OnPhpFinished);
		}
		
		public function OnPhpFinished(evt:Event):void
		{
			trace(evt.target.data);
		}
		
		public function CreateLayers():void
		{
				LAYER_BKG = new FlxGroup();
				LAYER_BKG1 = new FlxGroup();
				LAYER_MID = new FlxGroup();
				LAYER_ITEM = new FlxGroup();
				LAYER_ENEMY = new FlxGroup();
				LAYER_FRONT = new FlxGroup();
				LAYER_TEST = new FlxGroup();
				
				add(LAYER_BKG);
				add(LAYER_BKG1);
				add(LAYER_ITEM);
				add(LAYER_MID);
				add(LAYER_ENEMY);
				add(LAYER_FRONT);
				add(LAYER_TEST);
		}
		
		public function FadeComplete(e:Event):void
		{
			trace("FADE IS DONE");
			
		}
		
		public function AddItemToPlayer( item:Pickup ):void
		{
			var n:Boolean = false;
			if (!PlayerHasItem(item))
			{
				PlayerCurrentItems.add(item);
				if (item.IsOfType(Pickup.ITEM_KEY))
					AddKeyToPlayer(item);
					
				item.kill();
			}
		}
		
		public function AddKeyToPlayer(item:Pickup):void
		{
			Keys++;
		}
		
		public function PlayerHasItem(item:Pickup):Boolean
		{
			for each(var i:Pickup in PlayerCurrentItems.members)
			{
				if ( i.PickupName().toLowerCase() == item.PickupName().toLowerCase())
				{
					return true;
				}
			}
			
			return false;
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(mPlayer, mCellLevel.ActiveRoom().MapCollisionData());
			FlxG.collide(getBulletMgr().getActiveBullets(), mCellLevel.ActiveRoom().MapCollisionData());
			FlxG.collide(getBulletMgr().getActiveBullets(), mCellLevel.ActiveRoom().mRaisableWalls);
			
			HandleEnemyCollision();
			HandleDebugInput();
			mCellLevel.update();
			
			//mBulletTest.handleInput();
			//mBulletTest.testUpdate();
			//testUpdateCam();
			//mWalkerTest.testUpdate();
			//mTurretTest.udpate();
			updateBullets();
		}
		
		public function updateBullets():void
		{
			mBulletMgr.removeInactiveBullets();
		}
		
		public function HandleDebugInput():void
		{
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				FlxG.switchState(new MenuState());
				//FlxG.switchState(new PlayState(mLevelToLoad));
				//mLevelTest.startTest();
			}
			if (FlxG.keys.SHIFT)
			{
					if (FlxG.keys.justPressed('W'))
			{
				mCellLevel.ChangeRoomInDirection(new Point(0,-1));
			}
			if (FlxG.keys.justPressed('S'))
			{
				mCellLevel.ChangeRoomInDirection(new Point(0, 1));
			}
			if (FlxG.keys.justPressed('A'))
			{
				mCellLevel.ChangeRoomInDirection(new Point(-1,0));
			}
			if (FlxG.keys.justPressed('D'))
			{
				mCellLevel.ChangeRoomInDirection(new Point(1,0));
			}
			
			if (FlxG.keys.justPressed('END')) {
				mCellLevel.ActiveRoom().testSwitch();
			}
			}
		
			
			if (FlxG.keys.justPressed('F1'))
			{
				var tile:FlxTileblock = mCellLevel.ActiveRoom().getRandomTile();
				if (tile == null)
					return;
					
				var pos:Point = new Point(tile.x * tile.width, tile.y * tile.height);
				var enemy:EnemySlime = new EnemySlime(this, pos);
				
				mCellLevel.ActiveRoom().addEnemyToRoom(enemy);
			}
			
			if (FlxG.keys.justPressed('F2'))
			{
				mCellLevel.ActiveRoom().reloadRoom();
			}
			
			if (FlxG.keys.justPressed('F3'))
			{
				mCellLevel.testreloadLevel();
			}
			
				
			
			if (FlxG.keys.justPressed('F4'))
			{
				mBeamTest.init();	
			}
		}
		
		public function HandleEnemyCollision():void
		{
			/*if (mPlayer.Attacking())
			{
				for (var i:int = 0; i < mLevel.Enemies().length; i++)
				{
					if (FlxG.collide(mPlayer.WeaponHitBox(), mLevel.Enemies().members[i].HitBox()))
					{	
						if (!mPlayer.IsFacingCharacter(mLevel.Enemies().members[i]))
							break;
						
						var e:Enemy =  mLevel.Enemies().members[i];
						e.OnHitCharacter(mPlayer);
					}
				}
			}*/
		}
		
		override public function draw():void 
		{
			super.draw();
		}
		
		public function ActivePlayer():PlayerCharacter
		{
			return mPlayer;
		}
		
		public function ActiveLevel():CellLevel
		{
			return mCellLevel;
		}
		
		public function getTileWidth():int {
			return TILE_WIDTH;
		}
		
		public function getTileHeight():int
		{
			return TILE_HEIGHT;
		}
		
		public function switchToLevelThroughPortal(p:CellLevelPortal)
		{
			ActiveLevel().clearLevel();
			
			var newLevel:CellLevel = new CellLevel(this);
			newLevel.LoadLevel(p.getDestination());
			mCellLevel = newLevel;
			mActivePortal = p;
			mActivePortal.Activated = true;
			//after level loads
			//set spawn point from p
		}
		
		public function onEnterLevel()
		{
			if (mActivePortal != null && mActivePortal.Activated)
			{
				var portalExit:CellLevelPortal =  mCellLevel.ActiveRoom().getPortalFromId(mActivePortal.getIdentifier());
				portalExit.passThroughPortal(mPlayer);
				
			}
			
			if (ActiveLevel().LoadFinished)
			{
				//mWalkerTest.initTest();
				//mTurretTest.inti();
				//mBeamTest.init();
			}
		}
		
		public function getBulletMgr():BulletManager
		{
			return mBulletMgr;
		}
		
		public function getResources():GameResources
		{
			return mResources;
		}
		
		public function PlaySoundEffect(name:String,vol:Number=1.0):void
		{
			if (!getResources().hasSound(name) )
				return;
				
			FlxG.play(getResources().getSound(name),vol);
		}
	}

}