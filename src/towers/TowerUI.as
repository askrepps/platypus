package towers 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TowerUI extends Entity 
	{
		private var uiImage:Image;
		public function TowerUI(x:int, y:int) 
		{
			uiImage = new Image(Assets.UPGRADE_UI);
			setHitboxTo(uiImage);
			this.x = x - this.halfWidth;
			this.y = y - this.halfHeight;
			graphic = uiImage;
			type = "upgradeUI";
		}
		
		override public function update():void
		{
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				// Do stuff
			}
			else
				if(Input.mousePressed)
					world.remove(this);
		}
		
	}

}