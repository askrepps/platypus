package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * Stores all asset imports and variables.
	 * @author Jonathan Benkovic
	 */
	public class Assets 
	{
		// Menus / Screens
		[Embed(source = "assets/gameOver.png")] public static const GAME_OVER:Class;
		[Embed(source = "assets/youWin.png")] public static const YOU_WIN:Class;
		[Embed(source = "assets/startScreen.png")] public static const START_SCREEN:Class;
		
		// UI Elements
		[Embed(source = "assets/upgradeUI.png")] public static const UPGRADE_UI:Class;
		[Embed(source = "assets/buildButton.png")] public static const BUILD_BUTTON:Class; 
		[Embed(source = "assets/buttonTest.png")] public static const BUTTON:Class;
		[Embed(source = "assets/buttonTest.png")] public static const BUTTON_DOWN:Class;
		[Embed(source = "assets/buttonTest.png")] public static const BUTTON_HOVER:Class;
		[Embed(source = "assets/hoverBackground.png")] public static const HOVER_BACK:Class;
		
		// Levels
		[Embed(source = "assets/nest.png")] public static const NEST:Class;
		[Embed(source = "assets/egg.png")] public static const EGG:Class;
		[Embed(source = "assets/map1.png")] public static const LEVEL_1_MAP:Class;
		
		// Towers
		[Embed(source = "assets/rangedTower1.png")] public static const RANGED_TOWER_1:Class;
		[Embed(source = "assets/rangedTower2.png")] public static const RANGED_TOWER_2:Class;
		[Embed(source = "assets/rangedTower3.png")] public static const RANGED_TOWER_3:Class;
		
		[Embed(source = "assets/aoeTower1.png")] public static const AOE_TOWER_1:Class;
		[Embed(source = "assets/aoeTower2.png")] public static const AOE_TOWER_2:Class;
		[Embed(source = "assets/aoeTower3.png")] public static const AOE_TOWER_3:Class;
		
		[Embed(source = "assets/airTower1.png")] public static const AIR_TOWER_1:Class;
		[Embed(source = "assets/airTower2.png")] public static const AIR_TOWER_2:Class;
		[Embed(source = "assets/airTower3.png")] public static const AIR_TOWER_3:Class;
		
		[Embed(source = "assets/meleeTower1.png")] public static const MELEE_TOWER_1:Class;
		[Embed(source = "assets/meleeTower2.png")] public static const MELEE_TOWER_2:Class;
		[Embed(source = "assets/meleeTower3.png")] public static const MELEE_TOWER_3:Class;
		
		[Embed(source = "assets/towerPlace.png")] public static const PLACE_TOWER:Class;
		
		// Projectiles
		[Embed(source = "assets/arrow.png")] public static const ARROW:Class;
		[Embed(source = "assets/wave.png")] public static const WAVE:Class;
		[Embed(source = "assets/explosion.png")] public static const EXPLOSION:Class;
		[Embed(source = "assets/greenExplosion.png")] public static const GREEN_EXPLOSION:Class;
		
		// Enemies
		[Embed(source = "assets/normalEnemy.png")] public static const NORMAL_ENEMY:Class;
		[Embed(source = "assets/fastEnemy.png")] public static const FAST_ENEMY:Class;
		[Embed(source = "assets/flyingEnemy.png")] public static const FLYING_ENEMY:Class;
		[Embed(source = "assets/armoredEnemy.png")] public static const ARMORED_ENEMY:Class;
		
		// Heroes
		[Embed(source = "assets/warriorWalk.png")] public static const WARRIOR_WALK:Class;
		[Embed(source = "assets/warriorCleave.png")] public static const WARRIOR_ATTACK:Class;
		[Embed(source = "assets/warriorHero.png")] public static const WARRIOR:Class;
		[Embed(source = "assets/rangerWalk.png")] public static const RANGER_WALK:Class;
		[Embed(source = "assets/mageHero.png")] public static const MAGE:Class;
		
		// Audio
		[Embed(source = "assets/platypusLoop.mp3")] public static const MUSIC_LOOP:Class;
	}
}