package levels 
{
	import enemies.FastEnemy;
	import enemies.FlyingEnemy;
	import enemies.NormalEnemy;
	
	import flash.geom.Point;
	
	import hero.Warrior;
	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import towers.AoETower;
	import towers.HoverText;
	import towers.RangedTower;
	import towers.Tower;
	import towers.TowerPlace;
	
	import ui.HUD;
	import ui.PauseScreen;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TestWorld extends World 
	{
		private var paused:Boolean;
		
		public function TestWorld() 
		{
			// Path info
			Global.curLevel = 1;
			var startPos:Point = Global.genPoint(Global.paths[Global.curLevel][0]);
			
			add(new TowerPlace(500, 300));
			add(new NormalEnemy(startPos.x,startPos.y));
			//add(new NormalEnemy(100, 275));
			add(new TowerPlace(300, 300));
			//add(new FastEnemy(0,8));
			add(new Nest(700, 200));
			
			Global.hero = new Warrior(Global.GAME_WIDTH / 2, Global.GAME_HEIGHT / 2);
			add(Global.hero);
			
			add(new HUD());
			
			Global.playerGold = 100000;
			paused = false;
		}
	
		override public function update():void
		{
			if (Input.pressed(Key.P))
			{
				// Add new world that is the pause screen.
				FP.world = new PauseScreen(this);
			}
			
			super.update();
		}
		
	}

}