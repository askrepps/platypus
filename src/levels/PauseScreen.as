package levels
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ui.Button;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class PauseScreen extends World 
	{
		private var curWorld:World;
		private var resumeButton:Button;
		
		public function PauseScreen(curWorld:World) 
		{
			this.curWorld = curWorld;
			curWorld.active = false;
			
			var text:String = "Resume";
			resumeButton = new Button(FP.screen.width / 2, FP.screen.height / 2, text, resume);
			
			add(resumeButton);
		}

		public function resume():void
		{
			Global.music.resume();
			curWorld.active = true;
			FP.world = curWorld;
		}
		
		override public function update():void
		{
			super.update();
			if(Input.pressed(Key.P))
			{
				resume();
			}
		}	
		
		override public function render():void
		{
			Draw.text("Paused", 0, 100, { size: 32, color: 0xFFFFFF, width: FP.screen.width, align: "center" } );
			super.render();
		}
	}
	
}