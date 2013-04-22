package levels 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.Button;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class StartScreen extends World 
	{
		
		public function StartScreen() 
		{
			addGraphic(new Image(Assets.START_SCREEN), -10, 0, 0);
			var button:Button = new Button(FP.screen.width / 2, FP.screen.height/2 - 100, "Play", play);
			button.layer = -42;
			add(button);
		}
		
		public function play():void
		{
			FP.world = new TestWorld();
		}
	}

}