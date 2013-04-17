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
		private var buttonR:Button;
		private var buttonM:Button;
		private var buttonA:Button;
		private var buttonAoE:Button;
		private var towerPlace:TowerPlace;
		
		public function BuildTowerUI(x:int, y:int, towerPlace:TowerPlace) 
		{	
			uiImage = new Image(Assets.UPGRADE_UI);
			setHitboxTo(uiImage);
			this.x = x - width/3.0;
			this.y = y - height/3.0;
			graphic = uiImage;
			type = "buildUI";
			this.towerPlace = towerPlace;
			this.collidable = false;
			buttonR = new Button(this.x + this.width/3.0, this.y, "Ranged", build, "Ranged"); 
			buttonM = new Button(this.x + (2*(this.width/3.0)), this.y + height/3.0, "Melee", build, "Melee"); 
			buttonA = new Button(this.x + this.width/3.0, this.y + (2*(height/3.0)), "Air", build, "Air"); 
			buttonAoE = new Button(this.x, this.y + this.width/3.0, "AoE", build, "AoE"); 
		}
		
		public function build(towerBuild:String):void
		{
			if(towerBuild == "Ranged")
				FP.world.add(new RangedTower(x + width / 3.0, y + height / 3.0));
			else if(towerBuild == "Melee")
				FP.world.add(new MeleeTower(x + width / 3.0, y + height / 3.0));
			else if(towerBuild == "Air")
				FP.world.add(new AirTower(x + width / 3.0, y + height / 3.0));
			else if(towerBuild == "AoE")
				FP.world.add(new AoETower(x + width / 3.0, y + height / 3.0));
			else
				trace("This shouldn't have happen.");
				
			FP.world.remove(this.towerPlace);
		}
		
		override public function removed():void
		{
			buttonR.name = null;
			FP.world.removeList(buttonR, buttonM, buttonA, buttonAoE);
		}
		
		override public function update():void
		{
			if (buttonR.name == null)
			{
				buttonR.name = "done";
				world.addList(buttonR, buttonM, buttonA, buttonAoE);
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