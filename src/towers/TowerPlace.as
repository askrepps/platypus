package towers 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	/**
	 * Location where the towers can be placed.
	 * @author Jonathan Benkovic
	 */
	public class TowerPlace extends Entity
	{
		private var buildUI:BuildTowerUI;
		private var towerImage:Image;
		
		public function TowerPlace(x:Number, y:Number) 
		{
			this.x = x;
			this.y = y;
			
			towerImage = new Image(Assets.PLACE_TOWER);
			
			buildUI = new BuildTowerUI(centerX, centerY);
			
			graphic = towerImage;
			
			setHitboxTo(towerImage);
		}
	
		override public function removed():void
		{
			FP.world.remove(buildUI);
		}
		
		override public function update():void
		{
			// Deal with displaying tower info when clicked
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				//world.add(new HoverText(x,y));
				if(Input.mousePressed)
					world.add(buildUI);
			}
			
		}
	}

}