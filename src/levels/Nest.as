package levels
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Nest extends Entity
	{
		public var eggCount:Number;
		
		public function Nest(startX:Number, startY:Number)
		{
			super();
			
			eggCount = Global.STARTING_EGG_COUNT;
			x = startX;
			y = startY;
			graphic = new Image(Assets.NEST);
			setHitboxTo(graphic);
			type = "nest";
		}
		
		public function stealEgg():Egg
		{
			var egg:Egg = null;
			
			if (eggCount > 0)
			{
				eggCount--;
				egg = new Egg(x, y);
				egg.visible = false;
			}
			
			return egg;
		}
		
		public function returnEgg():void
		{
			eggCount++;
		}
	}
}