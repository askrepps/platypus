package ui 
{
	import adobe.utils.CustomActions;
	import flash.display.Graphics;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Draw;
	import towers.HoverText;
	
	public class BuildButton extends Entity
	{
		//DECLARATIONS
		protected var normal:Graphic;
		protected var clicked:Boolean = false;
		protected var label:Text;
		public var callback:Function;
		public var params:Object;
		public var enabled:Boolean;
		
		//DEFAULT CONSTRUCTOR FOR BUTTONS
		public function BuildButton(x:Number = 0, y:Number = 0, text:String = "", callback:Function = null, params:Object = null)
		{
			var normalImage:Image = new Image(Assets.BUILD_BUTTON);
			label = new Text(text, 1, normalImage.height/2, {size: 8, color: 0xFFFFFF, width: normalImage.width, wordWrap: true, align: "center"});
			label.y = (normalImage.height - label.textHeight) * 0.5;
			
			this.x = x;
			this.y = y;
			
			this.callback = callback;
			this.params = params;
			enabled = true;
			
			normal = new Graphiclist(normalImage, label);
			graphic = normal;
			setHitboxTo(normalImage);
			
		}
		
		//UPDATE FUNCTION WHICH CHANGES THE VISUAL VALUE OF BUTTONS
		override public function update():void
		{ 	
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				if (Input.mousePressed)
					clicked = true;
				
				if (clicked && Input.mouseReleased)
					click();
			}
			
			if (Input.mouseReleased)
				clicked = false;
		}
		
		protected function click():void
		{
			if (callback != null)
			{
				if (params != null) callback(params);
				else callback();
			}
		}
		
		public function drawRange():void
		{
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				if(params == "Ranged")
				{
					Draw.circlePlus(centerX, centerY + this.height, Global.RANGED_RANGE,	0xbbd0fb , .08, true);
				}
				else if(params == "Melee")
				{
					Draw.circlePlus(centerX - this.width, centerY, Global.MELEE_RANGE,	0xbbd0fb , .08, true); 	
				}
				else if(params == "Air")
				{
					Draw.circlePlus(centerX, centerY - this.height, Global.AIR_RANGE,	0xbbd0fb , .08, true); 	
				}
				else if(params == "AoE")
				{
					Draw.circlePlus(centerX + this.width, centerY, Global.AOE_RANGE,	0xbbd0fb , .08, true); 	
				}
				else
				{
					
				}	
			}
		}
		
		override public function render():void
		{
			super.render();
			drawRange();
			
			if (!enabled)
				Draw.rect(x,y, width, height, 0x000000, 0.75);
		}
	}

}