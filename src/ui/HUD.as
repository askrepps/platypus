package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class HUD extends Entity
	{
		private var label:Text;
		
		public function HUD() 
		{

			label = new Text("", 1, 20, { size: 14, color: 0xFFFFFF, align: "center" } );
			//this.x = FP.screen.width - label.textWidth - 10;
			//this.y = FP.screen.height - 20;
			label.x = 400;
			label.y = 400;
			graphic = label;
			
		}
		
		override public function update():void
		{
			label.text = String("Gold " + Global.playerGold.toString());
		}
	}

}