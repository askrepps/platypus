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
		
		
		public function PauseScreen(curWorld:World) 
		{
			this.curWorld = curWorld;
			
			curWorld.active = false;
		}
		
		override public function update():void
		{
			if(Input.pressed(Key.P))
			{
				curWorld.active = true;
				FP.world = curWorld;
			}
		}	
	}
}