package towers 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TowerUI extends Entity 
	{
		private var uiImage:Image;
		private var tower:Tower;
		private var button:Button;
		public function TowerUI(x:int, y:int, tower:Tower) 
		{	
			uiImage = new Image(Assets.UPGRADE_UI);
			setHitboxTo(uiImage);
			this.x = x - this.halfWidth;
			this.y = y - this.halfHeight;
			graphic = uiImage;
			type = "upgradeUI";
			this.tower = tower;
			
			
			button = new Button(this.x + 40, this.y, "Upgrade", upgrade); 
		}
		
		public function upgrade():void
		{
			this.tower.upgrade();
		}
		
		override public function removed():void
		{
			FP.world.remove(button);
		}
		
		override public function update():void
		{
			if (world.getInstance(button.toString()) == null)
			{
				world.add(button);
			}
			
			
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