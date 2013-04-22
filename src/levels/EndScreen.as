package levels 
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import ui.Button;

	public class EndScreen extends World 
	{
		private var text:String;
		
		public function EndScreen(text:String, won:Boolean) 
		{
			this.text = text;
			
			if (won)
				addGraphic(new Image(Assets.YOU_WIN), -10, 0, 0);
			else
				addGraphic(new Image(Assets.GAME_OVER), -10, Global.GAME_WIDTH / 2 - 400, Global.GAME_HEIGHT / 2 - 400);
				
			var button:Button = new Button(FP.screen.width / 2, FP.screen.height - 100, "Play Again?", playAgain);
			button.layer = -42;
			add(button);
		}
		
		public function playAgain():void
		{
			FP.world = new TestWorld();
		}
		
		
		override public function render():void
		{
			super.render();
			Draw.text(text, 0, 100, { size: 48, color: 0xFFFFFF, width: FP.screen.width, align: "center" } );
		}
	}

}