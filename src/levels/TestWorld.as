package levels 
{
	import enemies.FastEnemy;
	import enemies.NormalEnemy;
	import towers.AoETower;
	import towers.TowerRangeMask;
	import towers.TowerPlace;
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
<<<<<<< HEAD
			add(new TowerPlace(500, 300));
=======
			//add(new RangedTower(300, 300));
>>>>>>> 3a2c69dee0b64b99c76b476b4f23ddd5ec144af6
			add(new NormalEnemy(20, 200));
			add(new NormalEnemy(100, 275));
			add(new TowerPlace(300, 300));
			
			//add(new FastEnemy(0,8));
			
			add(new Warrior(Global.GAME_WIDTH / 2, Global.GAME_HEIGHT / 2));
		}
		
	}

}