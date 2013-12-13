package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class XMLHelper 
	{
		
		public function XMLHelper() 
		{
			
		}
		
		public static function getAttribute(name:String, node:XML):String
		{
			for each(var attr in node.attributes())
			{
				if (attr.name() == name)
					return attr;
			}
			
			return "";
		}
		
	}

}