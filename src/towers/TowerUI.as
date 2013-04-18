package towers 
{
	import mx.core.ButtonAsset;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	import ui.Button;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TowerUI extends Entity 
	{
		private var uiImage:Image;
		private var tower:Tower;
		private var button:Button;
		private var deleteButton:Button;
		
		public function TowerUI(x:int, y:int, tower:Tower) 
		{	
			uiImage = new Image(Assets.UPGRADE_UI);
			setHitboxTo(uiImage);
			this.x = x - width/3;
			this.y = y - height/3;
			graphic = uiImage;
			type = "upgradeUI";
			this.tower = tower;
			
			button = new Button(this.x + width / 3, this.y, "Upgrade", upgrade); 
			deleteButton = new Button(this.x + width / 3, this.y + (2 * (width / 3)), "Delete", deleteTower); 
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
		
		override public function removed():void
		{
			button.name = null;
			FP.world.remove(button);
			FP.world.remove(deleteButton);
		}
		
		override public function update():void
		{
			if (button.name == null)
			{
				button.name = "done";
				world.add(button);
				world.add(deleteButton);
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