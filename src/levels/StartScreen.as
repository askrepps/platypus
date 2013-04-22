package levels 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import ui.Button;
	/**
	 * ...
	 * @author ...
	 */
	public class StartScreen extends World 
	{
		
		public function StartScreen() 
		{
			var button:Button = new Button(FP.screen.width / 2, FP.screen.height/2, "Play", play);
			button.layer = -42;
			add(button);
		}
		
		public function play():void
		{
			FP.world = new TestWorld();
		}
	}

}