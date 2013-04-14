package towers 
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class HoverText extends Entity 
	{
		private var label:Text;
		
		public function HoverText(x:Number, y:Number) 
		{
			this.x = x;
			this.y = y;
			
			label = new Text("Testing the label", 10, 0, { size: 16, color: 0x000000, width: 120, wordWrap: true, align: "center" } );
			
			
			graphic = label;
		}
		
		override public function render():void
		{
			Draw.rectPlus(x, y, 150, 75, 0x626262, 1, true, 1, 10);
		}
		
	}

}