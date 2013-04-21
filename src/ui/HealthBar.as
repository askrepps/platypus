package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class HealthBar extends Entity 
	{
		private var curVal:Number;
		private var recWidth:Number;
		private var recHeight:Number;
		
		public function HealthBar(x:Number, y:Number, recWidth:Number, recHeight:Number, curVal:Number) 
		{
			this.curVal = curVal;
			this.x = x;
			this.y = y;
			this.recHeight = recHeight;
			this.recWidth = recWidth;
		}
		
		public function updateVal(x:Number, y:Number, value:Number):void
		{
			this.x = x;
			this.y = y;
			
			if(curVal > 1)
				curVal = 1;
			else
				curVal = value;
		}
		
		override public function render():void
		{
			Draw.rect(x - recWidth/2.0, y - 10, recWidth, recHeight, 0x000000);
			Draw.rect(x - recWidth / 2.0, y - 10, recWidth * curVal, recHeight, 0x9A1D1D);
		}
		
	}

}