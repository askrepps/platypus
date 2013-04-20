package levels
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Egg extends Entity
	{
		public var isCarried:Boolean;
		
		public function Egg(startX:Number, startY:Number)
		{
			super();
			
			graphic = new Image(Assets.EGG);
			setHitboxTo(graphic);
			x = startX;
			y = startY;
			
			isCarried = true;
			type = "egg";
		}
		
		public function updatePos(newX:Number, newY:Number):void
		{
			x = newX;
			y = newY;
		}
	}
}