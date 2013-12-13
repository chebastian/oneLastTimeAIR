package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class AnimationClip 
	{
		public var name:String;
		public var fps:Number;
		public var frames:Array;
		public var fw:Number;
		public var fh:Number;
		public var center:Point;
		public var src:Class;
		public var looped:Boolean;
		public var origin:Point;
		
		public function AnimationClip(name:String,frames:Array,fw:Number,fh:Number,src:Class) 
		{
				this.name = name; this.frames = frames; this.fw = fw; this.fh = fh; 
				this.src = src;
				this.looped = true;
				this.origin = new Point(0, 0);
				this.center = new Point(fw * 0.5, fh * 0.5);
		}
		
	}

}