package  
{
	/**
	 * Stores global variables for the entire program.
	 * @author Jonathan Benkovic
	 */
	public class Global 
	{
		// Game Parameters
		public static const GAME_WIDTH:Number = 800;             // Note: change SWF parameters in Main.as to match
		public static const GAME_HEIGHT:Number = 600;
		
		
		// Tower Attributes, see Tower.as for description of variables
		
		// Melee Tower starting attributes
		public static const MELEE_RANGE:Number = 10;
		public static const MELEE_DAMAGE:Number = 10;		
		public static const MELEE_SPEED:Number = 1;			
		public static const MELEE_CANATTACK:Array = new Array("normal", "fast", "armored"); 		
		public static const MELEE_ARMORPIERCING:Number = 10;  
		public static const MELEE_SPECIAL:String = "None";		
		public static const MELEE_TOWERDESCIPT:String = "Basic melee tower.  Can only hit ground units.";
		
		// Ranged Tower starting attributes
		public static const RANGED_RANGE:Number = 200;
		public static const RANGED_DAMAGE:Number = 2;		
		public static const RANGED_SPEED:Number = .5;			
		public static const RANGED_CANATTACK:Array = new Array("normal", "fast", "armored", "flying"); 		
		public static const RANGED_ARMORPIERCING:Number = 1;  
		public static const RANGED_SPECIAL:String = "None";		
		public static const RANGED_TOWERDESCIPT:String = "Basic ranged tower. Can hit any unit.";
		
		// AoE Tower starting attributes
		public static const AOE_RANGE:Number;
		public static const AOE_DAMAGE:Number;		
		public static const AOE_SPEED:Number;			
		public static const AOE_CANATTACK:Array = new Array("normal", "fast", "armored"); 		
		public static const AOE_ARMORPIERCING:Number;  
		public static const AOE_SPECIAL:String;		
		public static const AOE_TOWERDESCIPT:String;
		
		// Air Tower starting attributes
		public static const AIR_RANGE:Number;
		public static const AIR_DAMAGE:Number;		
		public static const AIR_SPEED:Number;			
		public static const AIR_CANATTACK:Array = new Array("flying"); 	
		public static const AIR_ARMORPIERCING:Number;  
		public static const AIR_SPECIAL:String;		
		public static const AIR_TOWERDESCIPT:String;
		
		
		// Hero Attributes, see Hero.as for description of variables
		
		// Warrior starting attributes
		public static const WARRIOR_HEALTH:Number = 10;
		public static const WARRIOR_ATTACK:Number = 1;
		public static const WARRIOR_DEFENSE:Number = 1;
		public static const WARRIOR_SPEED:Number = 5;
		
		// Ranger starting attributes
		public static const RANGER_HEALTH:Number = 10;
		public static const RANGER_ATTACK:Number = 1;
		public static const RANGER_DEFENSE:Number = 1;
		public static const RANGER_SPEED:Number = 5;

		// Mage starting attributes
		public static const MAGE_HEALTH:Number = 10;
		public static const MAGE_ATTACK:Number = 1;
		public static const MAGE_DEFENSE:Number = 1;
		public static const MAGE_SPEED:Number = 5;

		// Experience stuff
		public static const MAX_LEVELS = 10;
		public static const XP_TO_LEVEL = new Array (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
		
	}

}