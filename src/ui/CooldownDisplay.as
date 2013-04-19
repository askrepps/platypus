package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class CooldownDisplay extends Entity 
	{
		private var curVal:Number;
		
		public function CooldownDisplay(x:Number, y:Number, curVal:Number) 
		{
			this.x = x;
			this.y = y;
			this.curVal = curVal;
		}
		
		public function updateVal(value:Number):void
		{
			curVal = value;
		}
			
		override public function render():void
		{
			Draw.rect(x, y, 40, 60, 0x000000);
			
			Draw.rect(x, y, 40, 60* curVal, 0x838b8b);
			
			/*
			if (curVal != 0)
			{
				var text:String = String(curVal.toString())
				Draw.text(text, centerX - text.length / 2, centerY);
			}
			*/
		}
		
	}

}