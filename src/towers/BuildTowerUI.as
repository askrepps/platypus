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
		private var buttonR:BuildButton;		// Ranged tower build button
		private var buttonM:BuildButton;		// Melee tower build button
		private var buttonA:BuildButton;		// Air tower build button
		private var buttonAoE:BuildButton;		// AoE tower build button
		private var towerPlace:TowerPlace;
		private var rHoverText:HoverText;		// Ranged button hover text
		private var aHoverText:HoverText;		// Air button hover text
		private var aoeHoverText:HoverText;		// AoE button hover text
		private var mHoverText:HoverText;		// Melee button hover text
		
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
				Global.playerGold -= Global.AOE_COST;
				FP.world.add(new AoETower(x + width / 3.0, y + height / 3.0));
				FP.world.remove(this.towerPlace);
			}
			else
			{
				// Not enough gold, do nothing.
			}	
			
		}
		
		override public function added():void
		{
			world.addList(buttonR, buttonM, buttonA, buttonAoE);
		}
		
		override public function removed():void
		{
			FP.world.removeList(buttonR, buttonM, buttonA, buttonAoE);
			
			for each(var hText:HoverText in new Array(mHoverText, aHoverText, rHoverText, aoeHoverText))
			{
				if (hText != null)
				{
					if (hText.name != null)
					{	
						hText.name = null;
						world.remove(hText);
					}
				}
			}
		}
		
		override public function update():void
		{
			if (buttonR.name == null)
			{
				buttonR.name = "done";
				world.addList(buttonR, buttonM, buttonA, buttonAoE);
			}
			else
			{
				// Dim the buttons if the player cannot buy the tower.
				if (Global.playerGold < Global.RANGED_COST)
				{
					buttonR.enabled = false;
				}
				if (Global.playerGold < Global.MELEE_COST)
				{
					buttonM.enabled = false;
				}
				if (Global.playerGold < Global.AIR_COST)
				{
					buttonA.enabled = false;
				}
				if (Global.playerGold < Global.AOE_COST)
				{
					buttonAoE.enabled = false;
				}
			}
			for each(var hText:HoverText in new Array(mHoverText, aHoverText, rHoverText, aoeHoverText))
			{
				if (hText != null)
				{
					if (hText.name != null)
					{	
						hText.name = null;
						world.remove(hText);
					}
				}
			}
			
			if (collideWith(buttonR, world.mouseX, world.mouseY))
			{
				if(rHoverText == null)
				{
					rHoverText = new HoverText(buttonR.x + buttonR.width, buttonR.y, "Ranged Tower\n\n Damage: " + Global.RANGED_DAMAGE.toString() + "\n" + Global.RANGED_TOWERDESCIPT);
					rHoverText.y -= rHoverText.height;
					rHoverText.name = "done";
					world.add(rHoverText);
				}
				else if(rHoverText.name == null)
				{
					rHoverText.name = "done";
					world.add(rHoverText);
				}
					
			}
			else if (collideWith(buttonAoE, world.mouseX, world.mouseY))
			{
				if(aoeHoverText == null)
				{
					aoeHoverText = new HoverText(buttonAoE.x + buttonAoE.width, buttonAoE.y, "AoE Tower\n\n Damage: " + Global.AOE_DAMAGE.toString() + "\n" + Global.AOE_TOWERDESCIPT);
					aoeHoverText.y -= aoeHoverText.height;
					aoeHoverText.name = "done";
					world.add(aoeHoverText);
				}
				else if(aoeHoverText.name == null)
				{
					aoeHoverText.name = "done";
					world.add(aoeHoverText);
				}
					
			}
			else if (collideWith(buttonM, world.mouseX, world.mouseY))
			{
				if(mHoverText == null)
				{
					mHoverText = new HoverText(buttonM.x + buttonM.width, buttonM.y, "Melee Tower\n\n Damage: " + Global.MELEE_DAMAGE.toString() + "\n" + Global.MELEE_TOWERDESCIPT);
					mHoverText.y -= mHoverText.height;
					mHoverText.name = "done";
					world.add(mHoverText);
				}
				else if(mHoverText.name == null)
				{
					mHoverText.name = "done";
					world.add(mHoverText);
				}		
			}
			else if (collideWith(buttonA, world.mouseX, world.mouseY))
			{
				if(aHoverText == null)
				{
					aHoverText = new HoverText(buttonA.x + buttonA.width, buttonA.y, "Air Tower\n\n Damage: " + Global.AIR_DAMAGE.toString() + "\n" + Global.AIR_TOWERDESCIPT);
					aHoverText.y -= aHoverText.height;
					aHoverText.name = "done";
					world.add(aHoverText);
				}
				else if(aHoverText.name == null)
				{
					aHoverText.name = "done";
					world.add(aHoverText);
				}
					
			}
			
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				
			}
			else
				if(Input.mousePressed)
					world.remove(this);
		}
	}
}