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
		[Embed(source = "assets/buildButton.png")] public static const BUILD_BUTTON:Class; 
		[Embed(source = "assets/button.png")] public static const BUTTON:Class;
		[Embed(source = "assets/button_down.png")] public static const BUTTON_DOWN:Class;
		[Embed(source = "assets/button_hover.png")] public static const BUTTON_HOVER:Class;
		[Embed(source = "assets/hoverBackground.png")] public static const HOVER_BACK:Class;
		// Levels
		
		// Towers
		[Embed(source = "assets/rangedTower.png")] public static const RANGED_TOWER:Class;
		[Embed(source = "assets/arrowProjectile.png")] public static const ARROW_PROJ:Class;
		[Embed(source = "assets/spearProjectile.png")] public static const SPEAR_PROJ:Class;
		[Embed(source="assets/bulletProjectile.png") ] public static const BULLET_PROJ:Class;
		[Embed(source = "assets/aoeTower.png")] public static const AOE_TOWER:Class;
		[Embed(source = "assets/airTower.png")] public static const AIR_TOWER:Class;
		[Embed(source = "assets/meleeTower.png")] public static const MELEE_TOWER:Class;
		[Embed(source = "assets/towerPlace.png")] public static const PLACE_TOWER:Class;
		
		// Enemies
		[Embed(source = "assets/normalEnemy.png")] public static const NORMAL_ENEMY:Class;
		
		// Heroes
		[Embed(source = "assets/warriorCleave.png")] public static const WARRIOR:Class;
		[Embed(source = "assets/rangerHero.png")] public static const RANGER:Class;
		[Embed(source = "assets/mageHero.png")] public static const MAGE:Class;
	}
}