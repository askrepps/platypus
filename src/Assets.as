package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * Stores all asset imports and variables.
	 * @author Jonathan Benkovic
	 */
	public class Assets 
	{
		// UI Elements
		[Embed(source = "assets/upgradeUI.png")] public static const UPGRADE_UI:Class;
		
		// Levels
		
		// Towers
		[Embed(source = "assets/rangedTower.png")] public static const RANGED_TOWER:Class;
		
		// Enemies
		[Embed(source = "assets/normalEnemy.png")] public static const NORMAL_ENEMY:Class;
		
		// Heroes
		[Embed(source = "assets/warriorHero.png")] public static const WARRIOR:Class;
		[Embed(source = "assets/rangerHero.png")] public static const RANGER:Class;
		[Embed(source = "assets/mageHero.png")] public static const MAGE:Class;
	}
}