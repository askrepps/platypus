package towers 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TowerUI extends Entity 
	{
		private var uiImage:Image;
		private var tower:Tower;
		public function TowerUI(x:int, y:int, tower:Tower) 
		{
			uiImage = new Image(Assets.UPGRADE_UI);
			setHitboxTo(uiImage);
			this.x = x - this.halfWidth;
			this.y = y - this.halfHeight;
			graphic = uiImage;
			type = "upgradeUI";
			this.tower = tower;
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
		
		override public function render():void
		{
			super.render();
			Draw.circlePlus(centerX, centerY, tower.range,	0xbbd0fb , .08, true); 	
		}
	}

}