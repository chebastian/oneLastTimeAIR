package  
{
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import RoomAssets.SwitchBeam;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BeamLoader 
	{
		var nodes:XMLList;
		var mGame:PlayState;
		public function BeamLoader(game:PlayState) 
		{
			mGame = game;
		}
		
		public function parseBeams(xml:XMLList):FlxGroup
		{
			nodes = xml;
			
			var points:Array = new Array();
			for each(var node in nodes)
			{
				var p:FlxPoint = parseBeam(node);
				points.push(p);
			}
			
			return createBeamsFromPoints(points);
		}
		
		private function parseBeam(xml:XML):FlxPoint
		{
			var x:Number = parseInt(XMLHelper.getAttribute("x", xml));
			var y:Number = parseInt(XMLHelper.getAttribute("y", xml));
			var p:FlxPoint = new FlxPoint(x, y);
			
			return p;
		}
		
		private function createBeamsFromPoints(points:Array):FlxGroup
		{
			var beams:FlxGroup = new FlxGroup();
			var beamLengths:Array = new Array();
			//var arr:Array();
			
			for each(var pointA:FlxPoint in points)
			{
				if (isFirstInLine(pointA,points))
				{
					var num:Number = numRightNeighbours(pointA, points);
					var beam:SwitchBeam = new SwitchBeam(mGame, pointA.x * mGame.getTileWidth(), pointA.y * mGame.getTileHeight());
					beam.setBeamLength(num);
					beams.add(beam);
				}
			}
			
			return beams;
		}
		
		private function numRightNeighbours(p:FlxPoint, points:Array):uint
		{
			var count = 0;
			if (hasRightNeighbour(p, points))
			{
				count++;
				count += numRightNeighbours(getRightNeighbour(p, points),points);
			}
			
			return count;
		}
		
		private function isFirstInLine(p:FlxPoint, points:Array):Boolean
		{
				for each(var point:FlxPoint in points)
				{
					var xd:Number = point.x - p.x;
					var yd:Number = point.y - p.y;
				
					if((xd == -1) && (yd == 0))
						return false;
				}
				
			return true;
		}
		
		private function hasRightNeighbour(p:FlxPoint, points:Array):Boolean
		{
			for each(var point:FlxPoint in points)
			{
				var xd:Number = point.x - p.x;
				var yd:Number = point.y - p.y;
				
				if((xd == 1) && (yd == 0))
					return true;
			}
			
			return false;
		}
		
		private function getRightNeighbour(p:FlxPoint, points:Array):FlxPoint
		{
			for each(var point:FlxPoint in points)
			{
				var xd:Number = point.x - p.x;
				var yd:Number = point.y - p.y;
				
				if ((xd == 1) && (yd == 0))
				{
					return point;
				}
			}
			
			return null;
		}
		
	}

}