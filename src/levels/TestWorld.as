package levels 
{
	import enemies.FastEnemy;
	import enemies.NormalEnemy;
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
		}
		
	}

}