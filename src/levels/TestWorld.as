package levels 
{
	import enemies.FastEnemy;
	import enemies.NormalEnemy;
	import towers.TowerRangeMask;
	
	import hero.Warrior;
	
	import net.flashpunk.World;
	
	import towers.RangedTower;
	import towers.Tower;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TestWorld extends World 
	{
		
		public function TestWorld() 
		{
			add(new RangedTower(300, 300));
			add(new NormalEnemy(20, 200));
			add(new NormalEnemy(100, 275));
			//add(new FastEnemy(0,8));
			add(new Warrior(Global.GAME_WIDTH / 2, Global.GAME_HEIGHT / 2));
		}
		
	}

}