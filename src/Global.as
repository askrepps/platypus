package  
{
	/**
	 * Stores global variables for the entire program.
	 * @author Jonathan Benkovic
	 */
	
	import flash.geom.Point;
	import hero.Hero;
	import net.flashpunk.Sfx;
	
	public class Global 
	{
		// Game Parameters
		public static const GAME_WIDTH:Number = 1024;             // Note: change SWF parameters in Main.as to match
		public static const GAME_HEIGHT:Number = 768;
		
		// Player variables
		public static var playerGold:int;	
		public static var eggsLeft:int;
		
		// Path data
		public static var curLevel:Number;
		public static var music:Sfx;
		public static const paths:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>(5);
		paths[0] = new Vector.<Point>(11);
		paths[1] = new Vector.<Point>(5);
		
		// First path
		paths[0][0] = new Point(.141, .997);
		paths[0][1] = new Point(.145, .755);
		paths[0][2] = new Point(.171, .612);
		paths[0][3] = new Point(.252, .560);
		paths[0][4] = new Point(.338, .542);
		paths[0][5] = new Point(.475, .527);
		paths[0][6] = new Point(.599, .521);
		paths[0][7] = new Point(.715, .479);
		paths[0][8] = new Point(.763, .384);
		paths[0][9] = new Point(.845, .260);
		paths[0][10] = new Point(.968, .049);
		
		// Second path
		paths[1][0] = new Point(.2, .2);
		paths[1][1] = new Point(.5, .5);
		paths[1][2] = new Point(.8, .2);
		paths[1][3] = new Point(.2, .8);
		paths[1][4] = new Point(.8, .8);
		
		// Waves of enemies
		public static var waveFrequency = 1;
		public static var waveCounter = 0;
		public static var wavePosition = 0;
		
		public static const NUM_WAVES = 4;
		
		// Waves
		// 0 - Normal 1 - Fast 3 - Armored 4 - Flying
		public static const waves:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>(5);
		waves[0] = new Vector.<Number>(5);
		waves[0][0] = 0;
		waves[0][1] = 0;
		waves[0][2] = 0;
		waves[0][3] = 0;
		waves[0][4] = 0;
		
		waves[1] = new Vector.<Number>(5);
		waves[1][0] = 0;
		waves[1][1] = 0;
		waves[1][2] = 0;
		waves[1][3] = 3;
		waves[1][4] = 3;
		
		waves[2] = new Vector.<Number>(5);
		waves[2][0] = 4;
		waves[2][1] = 4;
		waves[2][2] = 4;
		waves[2][3] = 4;
		waves[2][4] = 4;
		
		waves[3] = new Vector.<Number>(5);
		waves[3][0] = 1;
		waves[3][1] = 1;
		waves[3][2] = 1;
		waves[3][3] = 1;
		waves[3][4] = 1;
		
		public static function genPoint(a:Point):Point
		{
			return new Point(a.x * GAME_WIDTH, a.y * GAME_HEIGHT);
		}
		
		// Other Level Stuff
		public static const STARTING_EGG_COUNT:Number = 100;

		
		// Tower Attributes, see Tower.as for description of variables
		
		// Tower and Upgrade Costs
		public static const RANGED_COST:Number = 50;
		public static const RANGED_UPGRADE_COST:Number = 100;
		
		public static const MELEE_COST:Number = 75;
		public static const MELEE_UPGRADE_COST:Number = 125;
		
		public static const AIR_COST:Number = 100;
		public static const AIR_UPGRADE_COST:Number = 200;
		
		public static const AOE_COST:Number = 100;
		public static const AOE_UPGRADE_COST:Number = 200;
		
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
		public static const POISON_DURATION:Number = 4;
		public static const POISON_DAMAGE:Number = 2;
		public static const AOE_TOWERDESCIPT:String = "Area damage tower.  Hits all ground enemies in the range."; 
		
		
		// Air Tower starting attributes
		public static const AIR_RANGE:Number = 150;
		public static const AIR_DAMAGE:Number = 5;		
		public static const AIR_SPEED:Number = .5;			
		public static const AIR_CANATTACK:Array = new Array("flying"); 	
		public static const AIR_ARMORPIERCING:Number = 5;  
		public static const AIR_SPECIAL:String = "";		
		public static const AIR_TOWERDESCIPT:String = "Special designed to take out flying enemies.";
		
		
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
		public static const AOE_RANGE_UPGRADE2:Number = 150;
		public static const AOE_DAMAGE_UPGRADE2:Number = 3;		
		public static const AOE_SPEED_UPGRADE2:Number = 1;	
		
		public static const AIR_RANGE_UPGRADE1:Number = 155;
		public static const AIR_DAMAGE_UPGRADE1:Number = 5.5;		
		public static const AIR_SPEED_UPGRADE1:Number = .4;	
		
		public static const AIR_RANGE_UPGRADE2:Number = 160;
		public static const AIR_DAMAGE_UPGRADE2:Number = 6;		
		public static const AIR_SPEED_UPGRADE2:Number = .5;	
		
		// Hero Attributes, see Hero.as for description of variables
		public static var hero:Hero;
		
		public static const HERO_SPEED_SCALE:Number = 50;
		public static const HERO_RECOVER_TIME:Number = 1;
		public static const HERO_BLINK_RATE:Number = 0.05;
		
		// Level to unlock each ability
		public static const ABILITY_1_LEVEL:Number = 1;
		public static const ABILITY_2_LEVEL:Number = 2;
		public static const ABILITY_3_LEVEL:Number = 3;
		
		// Warrior attributes
		public static const WARRIOR_HEALTH_ARRAY:Array =  new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const WARRIOR_ATTACK_ARRAY:Array =  new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const WARRIOR_DEFENSE_ARRAY:Array = new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		public static const WARRIOR_SPEED_ARRAY:Array =   new Array( 1,  2,  3,  4,  5,  6,  7,  8,  9, 10);
		
		public static const WARRIOR_DASH_SPEED:Number = 8;
		public static const WARRIOR_DASH_TIME:Number = 0.5;
		
		//public static const WARRIOR_CLEAVE_RANGE:Number = 100;
		public static const WARRIOR_LEAP_RANGE:Number = 200;
		public static const WARRIOR_LEAP_SPEED:Number = 10;
		public static const WARRIOR_LEAP_ATTACK_RANGE:Number = 100;
		
		public static const WARRIOR_ABIL_1_NAME:String = "Cleave";
		public static const WARRIOR_ABIL_1_DESC:String = "Attack enemies in a wide arc in front of you. Cooldown: 0.5 seconds";
		public static const WARRIOR_ABIL_1_CD:Number = 0.5;
		
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
		
		
		// Enemy traits
		public static const NORMAL_HEALTH = 50;
		public static const NORMAL_SPEED = 100;
		public static const NORMAL_ARMOR = 1;
		public static const NORMAL_XP = 1;
		
		public static const FAST_HEALTH = 50;
		public static const FAST_SPEED = 160;
		public static const FAST_ARMOR = 0;
		public static const FAST_XP = 1;
		
		public static const FLYING_HEALTH = 50;
		public static const FLYING_SPEED = 100;
		public static const FLYING_ARMOR = 1;
		public static const FLYING_XP = 1;
		
		public static const ARMORED_HEALTH = 100;
		public static const ARMORED_SPEED = 75;
		public static const ARMORED_ARMOR = 3;
		public static const ARMORED_XP = 1;
		
		
		
	}
}