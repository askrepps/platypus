package levels 
{
	import enemies.FastEnemy;
	import enemies.NormalEnemy;
	import flash.geom.Point;
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
			// Path info
			Global.curLevel = 1;
			var startPos:Point = Global.genPoint(Global.paths[Global.curLevel][0]);
			
			add(new TowerPlace(500, 300));
			add(new NormalEnemy(startPos.x,startPos.y));
			//add(new NormalEnemy(100, 275));
			add(new TowerPlace(300, 300));
			
			//add(new FastEnemy(0,8));
			
			add(new Warrior(Global.GAME_WIDTH / 2, Global.GAME_HEIGHT / 2));
		}
		
	}

}