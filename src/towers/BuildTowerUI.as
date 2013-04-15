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
	public class BuildTowerUI extends Entity 
	{
		private var uiImage:Image;
		private var tower:Tower;
		private var button:Button;
		public function BuildTowerUI(x:int, y:int) 
		{	
			uiImage = new Image(Assets.UPGRADE_UI);
			setHitboxTo(uiImage);
			this.x = x - width/3.0;
			this.y = y - height/3.0;
			graphic = uiImage;
			type = "upgradeUI";
			
			button = new Button(this.x + 40, this.y, "Ranged", build, "Ranged"); 
		}
		
		public function build(towerBuild:String):void
		{
			if(towerBuild == "Ranged")
				FP.world.add(new RangedTower(x + width/3.0, y + height/3.0));
		}
		
		override public function removed():void
		{
			FP.world.remove(button);
		}
		
		override public function update():void
		{
			if (button.name == null)
			{
				button.name = "done";
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
	}
}