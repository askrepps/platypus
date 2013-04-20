package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class CooldownDisplay extends Entity 
	{
		private var curVal:Number;
		private var callback:Function;
		private var clicked:Boolean;
		private var label:Text;
		private var text:String;
		
		public function CooldownDisplay(x:Number, y:Number, curVal:Number, text:String, callback:Function) 
		{
			this.x = x;
			this.y = y;
			this.curVal = curVal;
			this.callback = callback;
			clicked = false;
			this.text = text;
			
			label = new Text(text, 1, 20, {size: 8, color: 0xFFFFFF, width: 40, wordWrap: true, align: "center"});

			setHitbox(40, 60);
		}
		
		public function updateVal(value:Number):void
		{
			curVal = value;
		}
			
		
		
		protected function click():void
		{
			if (callback != null)
			{
				callback();
			}
		}
		
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
				
			super.update();
		}
		
		override public function render():void
		{
			Draw.rect(x, y, 40, 60, 0x000000);
			Draw.rect(x, y, 40, 60*curVal, 0x838b8b);
			
			
			Draw.text(text, x, this.y + ((height - label.textHeight) * 0.5), {size:10, color: 0xFFFFFF, width: 40, wordWrap: true, align: "center"});
			/*
			if (curVal != 0)
			{
				var text:String = String(curVal.toString())
				Draw.text(text, centerX - text.length / 2, centerY);
			}
			*/
		}
		
	}

}