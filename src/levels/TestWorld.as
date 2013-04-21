package levels 
{
	import enemies.Enemy;
	import enemies.FastEnemy;
	import enemies.FlyingEnemy;
	import enemies.NormalEnemy;
	import enemies.ArmoredEnemy;
	
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
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TestWorld extends World 
	{
		private var paused:Boolean;
		private var startPos:Point;
		private var waveCounter:Number;
		private var waveTimer:Number;
		
		public function TestWorld() 
		{
			waveCounter = 0;
			waveTimer = 0;
			// Grab path info
			Global.curLevel = 0;
			startPos = Global.genPoint(Global.paths[Global.curLevel][0]);
			
			add(new TowerPlace(500, 300));
			add(new TowerPlace(300, 300));

			add(new Nest(700, 200));
			
			Global.hero = new Warrior(Global.GAME_WIDTH / 2, Global.GAME_HEIGHT / 2);
			add(Global.hero);
			
			add(new HUD());
			
			Global.playerGold = 100000;
			paused = false;
		}
		
		// Send enemies along the path determined by global waves[][] vector
		public function sendEnemies():void {
			waveCounter += FP.elapsed;
			if (waveCounter >= Global.waveFrequency) {
				waveCounter -= Global.waveFrequency;
				
				if (Global.wavePosition < Global.waves[Global.curLevel].length) {
					this.add(genEnemy(Global.waves[Global.curLevel][Global.wavePosition++]));
				}
				else {
					waveTimer += FP.elapsed;
					if (waveTimer > 15) {
						FP.log(waveTimer);
						waveTimer = 0;
						Global.curLevel++;
					}
				}
			}
			
		}
		
		// Generate an enemy type based on the type number passed in
		public function genEnemy(type:Number):Enemy {
			switch (type) {
				case 0: 
					return new NormalEnemy(startPos.x, startPos.y);
				case 1:
					return new FastEnemy(startPos.x, startPos.y);
				case 2:
					return new FlyingEnemy(startPos.x, startPos.y);
				default:
					return new ArmoredEnemy(startPos.x, startPos.y);
			}
		}
	
		override public function update():void
		{
			sendEnemies();
			
			if (Input.pressed(Key.P))
			{
				// Add new world that is the pause screen.
				FP.world = new PauseScreen(this);
			}
			
			super.update();
		}
		
	}

}