package  
{
	import CharacterStates.TurretIdleState;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyFactory 
	{
		var mGame:PlayState;
		
		public function EnemyFactory(game:PlayState) 
		{
			mGame = game;
		}
		
		
		public function createEnemyFromXMLNode(xml:XML):Enemy 
		{
			var x:int = parseInt( readAttribute("x",xml) ) * mGame.getTileWidth();
			var y:int = parseInt( readAttribute("y",xml) ) * mGame.getTileHeight();
			
			var enemyType = readAttribute("type",xml);
			
			/*if (enemyType == "walker")
				e = new EnemyWalker(mGame, new Point(x, y));
			else if (enemyType == "turretR" || enemyType == "turretL" || enemyType == "turret")
				e = new EnemyTurret(mGame, new Point(x, y));
			else
			{
				e = new EnemyTurret(mGame, new Point(x, y));
			}*/
			
			var e:Enemy = createEnemyFromType(enemyType,new Point(x,y));
			//e.setPosition(new Point(x, y));
			
			return e;
		}
		
		protected function createEnemyFromType(type:String, pos:Point):Enemy
		{
			if (type == "walker")
			{
				return new EnemyWalker(mGame, pos);
			}
			
			if (type == "turretR")
			{
				var t:EnemyTurret = new EnemyTurret(mGame, pos);
				t.setHeading(new Point(1, 0));
				return t;
			}
			
			else if (type == "turretL")
			{
				var t:EnemyTurret = new EnemyTurret(mGame, pos);
				t.setHeading(new Point( -1, 0));
				return t;
			}
			
			else if (type == "turretUp")
			{
				var t:EnemyTurret = new EnemyTurret(mGame, pos);
				t.setHeading(new Point( 0, -1));
				return t;
			}
			
			else if (type == "turretDown")
			{
				var t:EnemyTurret = new EnemyTurret(mGame, pos);
				t.setHeading(new Point( 0, 1));
				return t;
			}
			
			else if (type == "flyer")
			{
				var tp:EnemyFlyer = new EnemyFlyer(mGame, pos);
				tp.setHeading(new Point( 0, 1));
				return tp;
			}
			else if (type == "jumper")
			{
				var jp:EnemyJumper= new EnemyJumper(mGame, pos);
				jp.setHeading(new Point( 0, 1));
				return jp;	
			}
			
			var e:Enemy = parseRepeaterEnemy(type, pos);
			if (e != null)
				return e;

			return new EnemyWalker(mGame, new Point(0, 0));
			
		}
		
		protected function readAttribute(name:String, attr:XML):String
		{
			for each(var node in attr.attributes())
			{
				if (node.name() == name)
					return node;
			}
			
			return "NOT FOUND";
		}
		
		protected function parseRepeaterEnemy(type:String,p:Point):Enemy
		{
			var e:EnemyRepeater = new EnemyRepeater(mGame, p);
			var h:Point = new Point(0, 0);
			if (type == "repeaterLeft")
			{
				h = new Point( -1, 0);
			}
			
			else if (type == "repeaterRight")
			{
				h = new Point( 1, 0);
			}
			
			else if (type == "repeaterDown")
			{
				h = new Point( 0, 1);
			}
			
			else if (type == "repeaterUp")
			{
				h = new Point( 0, -1);
			}
			else 
				return null;
			
			e.setHeading(h);
			return e;
		}
		
		
	}

}