package levels 
{
	import enemies.FastEnemy;
	import enemies.NormalEnemy;
	import towers.AoETower;
	import towers.HoverText;
	import towers.TowerRangeMask;
	import towers.TowerPlace;
	import hero.Warrior;
	import ui.HUD;
	
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import ui.PauseScreen;
	
	import towers.RangedTower;
	import towers.Tower;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TestWorld extends World 
	{
		private var paused:Boolean;
		
		public function TestWorld() 
		{
			add(new TowerPlace(500, 300));
			add(new NormalEnemy(20, 200));
			add(new NormalEnemy(100, 275));
			add(new TowerPlace(300, 300));
			add(new HoverText(40, 40, "TEST"));
			//add(new FastEnemy(0,8));
			
			add(new Warrior(Global.GAME_WIDTH / 2, Global.GAME_HEIGHT / 2));
			
			add(new HUD());
			
			Global.playerGold = 500;
			paused = false;
		}
	
		override public function update():void
		{
			if (Input.pressed(Key.P))
			{
				FP.world = new PauseScreen(this);
				// Add new world that is the pause screen.
			}
			
			super.update();
		}
		
	}

}