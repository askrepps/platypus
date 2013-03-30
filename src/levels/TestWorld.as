package levels 
{
	import enemies.FastEnemy;
	import enemies.NormalEnemy;
	
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
			add(new RangedTower(100, 100));
			add(new NormalEnemy(20, 100));
			add(new NormalEnemy(100, 20));
			//add(new FastEnemy(0,8));
			
			add(new Warrior(Global.GAME_WIDTH / 2, Global.GAME_HEIGHT / 2));
		}
		
	}

}