package
{
	import net.flashpunk.Engine;	
	import net.flashpunk.FP;
	
	[SWF(width="800", height="600")]
	
	public class Main extends Engine
	{
		
		public function Main()
		{
			super(800, 600, 60, false);
			//FP.world = new MyWorld();
		}
		
		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
	}
}