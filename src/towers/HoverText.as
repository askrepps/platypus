package towers 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class HoverText extends Entity 
	{
		private var label:Text;
		private var hoverBack:Graphiclist;
		
		public function HoverText(x:Number, y:Number, text:String) 
		{
			this.x = x;
			this.y = y;
			
			var normalImage:Image = new Image(Assets.HOVER_BACK);
			label = new Text(text, 1, 20, {size: 12, color: 0xFFFFFF, width: normalImage.width, wordWrap: true, align: "center"});
			label.y = (normalImage.height - label.textHeight) * 0.5;
			hoverBack = new Graphiclist(normalImage, label);
			
			graphic = hoverBack;
			
			setHitboxTo(normalImage);
		}
	}
}