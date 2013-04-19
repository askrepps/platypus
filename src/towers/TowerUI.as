package towers 
{
	import mx.core.ButtonAsset;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	import ui.BuildButton;
	/**
	 * UI that appears when the player clicks on a tower.
	 * @author Jonathan Benkovic
	 */
	public class TowerUI extends Entity 
	{
		private var uiImage:Image;
		private var tower:Tower;
		private var upgradeButton:BuildButton;
		private var deleteButton:BuildButton;
		
		public function TowerUI(x:int, y:int, tower:Tower) 
		{	
			uiImage = new Image(Assets.UPGRADE_UI);
			setHitboxTo(uiImage);
			this.x = x - width/3;
			this.y = y - height/3;
			graphic = uiImage;
			type = "upgradeUI";
			this.tower = tower;
			
			
			upgradeButton = new BuildButton(this.x + width / 3, this.y, "Upgrade", upgrade); 
			deleteButton = new BuildButton(this.x + width / 3, this.y + (2 * (width / 3)), "Delete", deleteTower); 
		}
		
		public function upgrade():void
		{
			if (tower.upgradeCur < 2)
			{
				if(Global.playerGold >= tower.upgradeCost)
				{
					Global.playerGold -= tower.upgradeCost;
					this.tower.upgrade();
				}
			}
		}
		
		public function deleteTower():void
		{
			if(tower.upgradeCur == 0)
				Global.playerGold += tower.cost * .30;
			else if (tower.upgradeCur == 1)
				Global.playerGold += (tower.cost + tower.upgradeCost) * .30;
			else 
				Global.playerGold += (tower.cost + tower.upgradeCost + tower.upgradeCost) * .30;
				
			world.add(new TowerPlace(tower.x, tower.y));
			world.remove(tower);
		}
		
		// Remove the buttons when the UI is removed.
		override public function removed():void
		{
			upgradeButton.name = null;
			FP.world.remove(upgradeButton);
			FP.world.remove(deleteButton);
		}
		
		override public function update():void
		{
			// Prevents multiple buttons from being made.
			if (upgradeButton.name == null)
			{
				upgradeButton.name = "done";
				world.add(upgradeButton);
				world.add(deleteButton);
			}
			
			// Remove the UI if the player clicks away from it.
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				// Do nothing, keep the UI up.
			}
			else
				if(Input.mousePressed)
					world.remove(this);
		}
		
		override public function render():void
		{
			super.render();
			
			// Draw a circle representing the range of the tower.
			Draw.circlePlus(centerX, centerY, tower.range,	0xbbd0fb , .08, true); 	
		}
	}

}