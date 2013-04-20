package levels
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
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
			if (eggCount > 0)
			{
				eggCount--;
				return new Egg(x, y);
			}
			
			return null;
		}
		
		public function returnEgg():void
		{
			eggCount++;
		}
	}
}