package towers 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class Button extends Entity
	{
		//DECLARATIONS
		protected var normal:Graphic;
		protected var clicked:Boolean = false;
		protected var label:Text;
		public var callback:Function;
		public var params:Object;
		
		[Embed(source="../assets/button.png")] public static const BUTTON:Class;
		
		//DEFAULT CONSTRUCTOR FOR BUTTONS
		public function Button(x:Number = 0, y:Number = 0, text:String = "", callback:Function = null, params:Object = null
		)
		{
			var normalImage:Image = new Image(BUTTON);
			label = new Text(text, 1, 20, {size: 8, color: 0xFFFFFF, width: normalImage.width, wordWrap: true, align: "center"});
			//label.y = (normalImage.height - label.textHeight) * 0.5;
			
			super(x, y);
			this.callback = callback;
			this.params = params;
			
			normal = new Graphiclist(normalImage, label);
			
			graphic = normal;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			
			setHitboxTo(normalImage);
		}
		
		//UPDATE FUNCTION WHICH CHANGES THE VISUAL VALUE OF BUTTONS
		override public function update():void
		{
			//CHANGES CLICKED BOOLEAN, AND CHANGES GRAPHIC TO THE DOWN PRESS
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
	}

}