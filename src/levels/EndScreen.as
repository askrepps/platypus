package levels 
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author ...
	 */
	public class EndScreen extends World 
	{
		private var text:String;
		
		public function EndScreen(text:String) 
		{
			this.text = text;
		}
		
		
		override public function render():void
		{
			Draw.text(text, 0, 100, { size: 48, color: 0xFFFFFF, width: FP.screen.width, align: "center" } );
			super.render();
		}
	}

}