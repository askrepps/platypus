package levels 
{
	import enemies.ArmoredEnemy;
	import enemies.Enemy;
	import enemies.FastEnemy;
	import enemies.FlyingEnemy;
	import enemies.NormalEnemy;
	import ui.BuildButton;
	import ui.Button;
	
	import flash.geom.Point;
	
	import hero.Warrior;
	
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
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
		private var music:Sfx;
		private var enemiesSent:Number;
		
		public function TestWorld() 
		{
			waveCounter = 0;
			waveTimer = 0;
			enemiesSent = 0;
			Global.eggsLeft = Global.STARTING_EGG_COUNT;
			
			// Grab path info
			Global.curLevel = 0;
			startPos = Global.genPoint(Global.paths[Global.curLevel][0]);
			addGraphic(new Image(Assets.LEVEL_1_MAP), 10, 0, 0);
			
			add(new TowerPlace(500, 300));
			add(new TowerPlace(300, 300));
			add(new TowerPlace(660, 280));
			add(new TowerPlace(200, 600));
			add(new TowerPlace(40, 560));
			add(new TowerPlace(930, 165));
			add(new TowerPlace(750, 80));
			add(new TowerPlace(410, 460));
			Global.nest = new Nest(915, 25);
			add(Global.nest);
			
			Global.hero = new Warrior(Global.GAME_WIDTH / 2, Global.GAME_HEIGHT / 2);
			add(Global.hero);
			
			add(new HUD());
			
			Global.playerGold = 500;
			paused = false;
			
			var button:BuildButton = new BuildButton(680, 0, "Next Wave", advanceWave);
			button.layer = -42;
			add(button);
		}
		
		public function advanceWave():void
		{
			if (waveTimer > 0)
			{
				waveTimer = 15;
				waveCounter = Global.waveFrequency;
				sendEnemies();
			}
			
		}
		
		// Send enemies along the path determined by global waves[][] vector
		public function sendEnemies():void 
		{
			waveCounter += FP.elapsed;
			waveTimer += FP.elapsed;

			if (waveCounter >= Global.waveFrequency) 
			{
				waveCounter -= Global.waveFrequency;
				
				if (enemiesSent < Global.waves[Global.curLevel].length) 
				{
					this.add(genEnemy(Global.waves[Global.curLevel][enemiesSent++]));
					waveTimer = 0;
				}
				else 
				{
					if (waveTimer > 15) 
					{
						enemiesSent = 0;
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
					return new NormalEnemy(startPos.x, startPos.y, Global.curLevel);
				case 1:
					return new FastEnemy(startPos.x, startPos.y, Global.curLevel);
				case 2:
					return new FlyingEnemy(startPos.x, startPos.y, Global.curLevel);
				default:
					return new ArmoredEnemy(startPos.x, startPos.y, Global.curLevel);
			}
		}
	
		override public function update():void
		{
			if(Global.curLevel < Global.NUM_WAVES)
				sendEnemies();
			else
			{
				var enemyCheck:Array = new Array;
				var win:Boolean = false;
				
				for each(var enemyType:String in Global.RANGED_CANATTACK)
				{
					this.getType(enemyType, enemyCheck);
					if (enemyCheck.length == 0)
						win = true;
					else
						win = false;
				}
				if(win)
					FP.world = new EndScreen("You Win!", true);
			}
				
			if (Global.eggsLeft == 0)
				FP.world = new EndScreen("Game Over", false);
				
			if (Input.pressed(Key.P))
			{
				// Add new world that is the pause screen.
				FP.world = new PauseScreen(this);
				Global.music.stop();
				
			}
			
			super.update();
		}
		
	}

}