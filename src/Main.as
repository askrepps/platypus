package
{
	import levels.TestWorld;
	import net.flashpunk.Engine;	
	import net.flashpunk.FP;
	
	[SWF(width="1024", height="768")]     // Note: change constants in Global.as to match
	
	public class Main extends Engine
	{
		
		public function Main()
		{
			super(Global.GAME_WIDTH, Global.GAME_HEIGHT, 60, false);
			FP.world = new TestWorld();
		}
		
		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
	}
}