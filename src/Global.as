package  
{
	/**
	 * Stores global variables for the entire program.
	 * @author Jonathan Benkovic
	 */
	
	import flash.geom.Point;
	
	public class Global 
	{
		// Game Parameters
		public static const GAME_WIDTH:Number = 1024;             // Note: change SWF parameters in Main.as to match
		public static const GAME_HEIGHT:Number = 768;
		
		// Path data
		public static var curLevel:Number;
		public static const paths:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>(5);
		paths[0] = new Vector.<Point>(6);
		paths[1] = new Vector.<Point>(5);
		
		// First path
		paths[0][0] = new Point(.1, .1);
		paths[0][1] = new Point(.2, .1);
		paths[0][2] = new Point(.3, .2);
		paths[0][3] = new Point(.5, .5);
		paths[0][4] = new Point(.7, .0);
		paths[0][5] = new Point(.0, .8);
		
		// Second path
		paths[1][0] = new Point(.2, .2);
		paths[1][1] = new Point(.5, .5);
		paths[1][2] = new Point(.8, .2);
		paths[1][3] = new Point(.2, .8);
		paths[1][4] = new Point(.8, .8);
		
		public static function genPoint(a:Point):Point
		{
			return new Point(a.x * GAME_WIDTH, a.y * GAME_HEIGHT);
		}

		
		// Tower Attributes, see Tower.as for description of variables
		
		// Melee Tower starting attributes
		public static const MELEE_RANGE:Number = 50;
		public static const MELEE_DAMAGE:Number = 10;		
		public static const MELEE_SPEED:Number = 1;			
		public static const MELEE_CANATTACK:Array = new Array("normal", "fast", "armored"); 		
		public static const MELEE_ARMORPIERCING:Number = 10;  
		public static const MELEE_SPECIAL:String = "Ignore Armor";		
		public static const MELEE_TOWERDESCIPT:String = "Basic melee tower.  Can only hit ground units.";
		
		// Ranged Tower starting attributes
		public static const RANGED_RANGE:Number = 100;
		public static const RANGED_DAMAGE:Number = 4;		
		public static const RANGED_SPEED:Number = .8;			
		public static const RANGED_CANATTACK:Array = new Array("normal", "fast", "armored", "flying"); 		
		public static const RANGED_ARMORPIERCING:Number = 1;  
		public static const RANGED_SPECIAL:String = "None";		
		public static const RANGED_TOWERDESCIPT:String = "Basic ranged tower. Can hit any unit.";
		
		// AoE Tower starting attributes
		public static const AOE_RANGE:Number = 75;
		public static const AOE_DAMAGE:Number = 2;		
		public static const AOE_SPEED:Number = 1;			
		public static const AOE_CANATTACK:Array = new Array("normal", "fast", "armored"); 		
		public static const AOE_ARMORPIERCING:Number = 5;  
		public static const AOE_SPECIAL:String = "Poison";		
		public static const AOE_TOWERDESCIPT:String;
		
		// Air Tower starting attributes
		public static const AIR_RANGE:Number = 150;
		public static const AIR_DAMAGE:Number = 5;		
		public static const AIR_SPEED:Number = .5;			
		public static const AIR_CANATTACK:Array = new Array("flying"); 	
		public static const AIR_ARMORPIERCING:Number = 5;  
		public static const AIR_SPECIAL:String = "";		
		public static const AIR_TOWERDESCIPT:String = "";
		
		
		// Upgrade variables
		public static const MELEE_RANGE_UPGRADE1:Number = 52;
		public static const MELEE_DAMAGE_UPGRADE1:Number = 12;		
		public static const MELEE_SPEED_UPGRADE1:Number = .9;		
		
		public static const MELEE_RANGE_UPGRADE2:Number = 55;
		public static const MELEE_DAMAGE_UPGRADE2:Number = 15;		
		public static const MELEE_SPEED_UPGRADE2:Number = .75;		
		
		public static const RANGED_RANGE_UPGRADE1:Number = 120;
		public static const RANGED_DAMAGE_UPGRADE1:Number = 6;		
		public static const RANGED_SPEED_UPGRADE1:Number = .6;	
		
		public static const RANGED_RANGE_UPGRADE2:Number = 140;
		public static const RANGED_DAMAGE_UPGRADE2:Number = 8;		
		public static const RANGED_SPEED_UPGRADE2:Number = .15;	
		
		
		public static const AOE_RANGE_UPGRADE1:Number = 80;
		public static const AOE_DAMAGE_UPGRADE1:Number = 2.5;		
		public static const AOE_SPEED_UPGRADE1:Number = .8;	
		public static const AOE_RANGE_UPGRADE2:Number = 85;
		public static const AOE_DAMAGE_UPGRADE2:Number = 3;		
		public static const AOE_SPEED_UPGRADE2:Number = 1;	
		
		public static const AIR_RANGE_UPGRADE1:Number = 155;
		public static const AIR_DAMAGE_UPGRADE1:Number = 5.5;		
		public static const AIR_SPEED_UPGRADE1:Number = .4;	
		
		public static const AIR_RANGE_UPGRADE2:Number = 160;
		public static const AIR_DAMAGE_UPGRADE2:Number = 6;		
		public static const AIR_SPEED_UPGRADE2:Number = .5;	
		
		// Hero Attributes, see Hero.as for description of variables
		public static const HERO_SPEED_SCALE:Number = 50;
		public static const HERO_RECOVER_TIME:Number = 1;
		public static const HERO_BLINK_RATE:Number = 0.05;
		
		// Level to unlock each ability
		public static const ABILITY_1_LEVEL:Number = 2;
		public static const ABILITY_2_LEVEL:Number = 5;
		public static const ABILITY_3_LEVEL:Number = 10;
		
		// Warrior attributes
		public static const WARRIOR_HEALTH_ARRAY:Array =  new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const WARRIOR_ATTACK_ARRAY:Array =  new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const WARRIOR_DEFENSE_ARRAY:Array = new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const WARRIOR_SPEED_ARRAY:Array =   new Array( 1,  2,  3,  4,  5,  6,  7,  8,  9, 10);
		
		public static const WARRIOR_ABIL_1_NAME:String = "blah";
		public static const WARRIOR_ABIL_1_DESC:String = "blah blah";
		public static const WARRIOR_ABIL_1_CD:Number = 3;
		
		public static const WARRIOR_ABIL_2_NAME:String = "blah";
		public static const WARRIOR_ABIL_2_DESC:String = "blah blah";
		public static const WARRIOR_ABIL_2_CD:Number = 5;
		
		public static const WARRIOR_ABIL_3_NAME:String = "blah";
		public static const WARRIOR_ABIL_3_DESC:String = "blah blah";
		public static const WARRIOR_ABIL_3_CD:Number = 10;
		
		// Ranger attributes
		public static const RANGER_HEALTH_ARRAY:Array =  new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const RANGER_ATTACK_ARRAY:Array =  new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const RANGER_DEFENSE_ARRAY:Array = new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const RANGER_SPEED_ARRAY:Array =   new Array( 5,  5,  5,  5,  5,  5,  5,  5,  5,  5);
		
		public static const RANGER_ABIL_1_NAME:String = "blah";
		public static const RANGER_ABIL_1_DESC:String = "blah blah";
		public static const RANGER_ABIL_1_CD:Number = 10;
		
		public static const RANGER_ABIL_2_NAME:String = "blah";
		public static const RANGER_ABIL_2_DESC:String = "blah blah";
		public static const RANGER_ABIL_2_CD:Number = 10;
		
		public static const RANGER_ABIL_3_NAME:String = "blah";
		public static const RANGER_ABIL_3_DESC:String = "blah blah";
		public static const RANGER_ABIL_3_CD:Number = 10;

		// Mage attributes
		public static const MAGE_HEALTH_ARRAY:Array =  new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const MAGE_ATTACK_ARRAY:Array =  new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const MAGE_DEFENSE_ARRAY:Array = new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const MAGE_SPEED_ARRAY:Array =   new Array( 5,  5,  5,  5,  5,  5,  5,  5,  5,  5);
		
		public static const MAGE_ABIL_1_NAME:String = "blah";
		public static const MAGE_ABIL_1_DESC:String = "blah blah";
		public static const MAGE_ABIL_1_CD:Number = 10;
		
		public static const MAGE_ABIL_2_NAME:String = "blah";
		public static const MAGE_ABIL_2_DESC:String = "blah blah";
		public static const MAGE_ABIL_2_CD:Number = 10;
		
		public static const MAGE_ABIL_3_NAME:String = "blah";
		public static const MAGE_ABIL_3_DESC:String = "blah blah";
		public static const MAGE_ABIL_3_CD:Number = 10;

		// Experience stuff
		public static const MAX_LEVELS:Number = 10;
		public static const XP_TO_LEVEL:Array = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
		
	}
}