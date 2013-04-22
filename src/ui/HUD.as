package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
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

			layer = -40;
		}

		override public function render():void
		{
			Draw.rect(0, 0, FP.screen.width, 40, 0x000000);
			Draw.text("Gold: " + Global.playerGold.toString(), 40, 10, { size: 20, color: 0xFFFFFF, align: "center" } )
			Draw.text("Eggs: " + Global.eggsLeft.toString(), 200, 10, { size: 20, color: 0xFFFFFF, align: "center" } )
			Draw.text("Hero Level: " + Global.hero.level.toString(), 320, 10, { size: 20, color: 0xFFFFFF, align: "center" } );
		}
	}

}