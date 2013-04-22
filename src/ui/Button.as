package ui 
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Stamp;
    import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Graphiclist
	import net.flashpunk.graphics.Image;
	
	public class Button extends Entity
	{
		protected var normal:Graphiclist;
		protected var hover:Graphiclist;
		protected var down:Graphiclist;
		protected var clicked:Boolean = false;
		protected const NORMAL:int = 0;
		protected const HOVER:int = 1;
		protected const DOWN:int = 2;
		public var callback:Function;				
		public var params:Object;
		public var label:Text;
		
		public function Button(x:Number=0, y:Number=0, text:String = "", callback:Function = null, params:Object = null)
		{
			super(x, y);			
			var normalImage:Image = new Image(Assets.BUTTON);
			
			label = new Text(text, 1, 20, {size: 24, color: 0xFFFFFF, width: normalImage.width, wordWrap: true, align: "center"});
			
			this.callback = callback;
			this.params = params;	
			normal = new Graphiclist(normalImage, label);
			hover = new Graphiclist(new Image(Assets.BUTTON_HOVER), label);
			down = new Graphiclist(new Image(Assets.BUTTON_DOWN), label);
			//Set hitbox to our graphic, so has same width and height of Stamp
			graphic = normal;
			setHitboxTo(normalImage);
			this.y -= this.halfHeight;
			this.x -= this.halfWidth;
		}
		
		override public function update():void
        {
            super.update();
             
			//Check if mouse position in the world collides with Button
            if (collidePoint(x, y, world.mouseX, world.mouseY))
            {
				//If mouse was pressed this frame, clicked
				if (Input.mousePressed) clicked = true;
				
				if (clicked)
					changeState(DOWN);
				else 
					changeState(HOVER);
					
				//Check if released and pressed in this frame
                if (clicked && Input.mouseReleased)
					click();
            }
			else {
				if (clicked)
					changeState(HOVER);
				else 
					changeState(NORMAL);
			}
			//Mouse released
			if (Input.mouseReleased)
				clicked = false;
        }
        
		protected function changeState(state:int = 0):void
		{
			switch(state)
			{
				case NORMAL:
					graphic = normal;
					break;
				case HOVER:
					graphic = hover;
					break;
				case DOWN:
					graphic = down;
					break;
			}
		}
		
		// Buttons is clicked, run the callback fucntion is there is one.
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