package ui 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
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
			add(new Button(FP.screen.width / 2, FP.screen.height / 2, text, resume));
		}

		public function resume():void
		{
			curWorld.active = true;
			FP.world = curWorld;
		}
		
		override public function update():void
		{
			if(Input.pressed(Key.P))
			{
				resume();
			}
		}	
	}
}