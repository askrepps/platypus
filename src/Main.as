package
{
	import levels.StartScreen;
	import levels.TestWorld;
	import net.flashpunk.Engine;	
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	[SWF(width="1024", height="768")]     // Note: change constants in Global.as to match
	
	public class Main extends Engine
	{
		
		public function Main()
		{
			super(Global.GAME_WIDTH, Global.GAME_HEIGHT, 60, false);
			FP.world = new StartScreen();
			FP.console.enable();
			Global.music = new Sfx(Assets.MUSIC_LOOP);
			Global.music.loop();
			Global.music.volume = 0.75;
		}
		
		override public function init():void
		{
			FP.log("FlashPunk has started successfully!");
		}
	}
}