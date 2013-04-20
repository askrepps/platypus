package towers 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	import ui.BuildButton;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class BuildTowerUI extends Entity 
	{
		private var uiImage:Image;
		private var tower:Tower;
		private var buttonR:BuildButton;
		private var buttonM:BuildButton;
		private var buttonA:BuildButton;
		private var buttonAoE:BuildButton;
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
			buttonR = new BuildButton(this.x + this.width/3.0, this.y, "Ranged\n" + Global.RANGED_COST.toString(), build, "Ranged"); 
			buttonM = new BuildButton(this.x + (2*(this.width/3.0)), this.y + height/3.0, "Melee\n" + Global.MELEE_COST.toString(), build, "Melee"); 
			buttonA = new BuildButton(this.x + this.width/3.0, this.y + (2*(height/3.0)), "Air\n" + Global.AIR_COST.toString(), build, "Air"); 
			buttonAoE = new BuildButton(this.x, this.y + this.width/3.0, "AoE\n" + Global.AOE_COST.toString(), build, "AoE"); 
		}
		
		public function build(towerBuild:String):void
		{
			if(towerBuild == "Ranged" && (Global.playerGold >= Global.RANGED_COST))
			{
				Global.playerGold -= Global.RANGED_COST;
				FP.world.add(new RangedTower(x + width / 3.0, y + height / 3.0));
				FP.world.remove(this.towerPlace);
			}
			else if(towerBuild == "Melee" && (Global.playerGold >= Global.MELEE_COST))
			{
				Global.playerGold -= Global.MELEE_COST;
				FP.world.add(new MeleeTower(x + width / 3.0, y + height / 3.0));
				FP.world.remove(this.towerPlace);
			}
			else if(towerBuild == "Air" && (Global.playerGold >= Global.AIR_COST))
			{
				Global.playerGold -= Global.AIR_COST;
				FP.world.add(new AirTower(x + width / 3.0, y + height / 3.0));
				FP.world.remove(this.towerPlace);
			}
			else if(towerBuild == "AoE" && (Global.playerGold >= Global.AOE_COST))
			{
				Global.playerGold >= Global.AOE_COST;
				FP.world.add(new AoETower(x + width / 3.0, y + height / 3.0));
				FP.world.remove(this.towerPlace);
			}
			else
			{
				// Not enough gold, do nothing.
			}	
			
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