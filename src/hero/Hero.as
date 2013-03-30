package hero
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Hero extends Entity
	{
		public var maxHealth:Number;             // max health
		public var currentHealth:Number;         // current health
		public var attack:Number;                // attack power
		public var defense:Number;               // defense
		public var speed:Number;                 // maximum speed
		
		public var level:Number;                 // current level
		public var xp:Number;                    // current experience points
		public var unlockedAbilities:Number;     // number of abilities available
		
		public var ability1CD:Number;            // remaining cooldown on ability 1
		public var ability2CD:Number;            // remaining cooldown on ability 2
		public var ability3CD:Number;            // remaining cooldown on ability 3
		
		public var heroImage:Image;              // hero graphic
		
		public function Hero(startX:Number, startY:Number) 
		{
			x = startX;
			y = startY;
			
			level = 1;
			xp = 0;
			unlockedAbilities = 3;       // all abilities unlocked for testing
			ability1CD = 0;
			ability2CD = 0;
			ability3CD = 0;
		}
		
		override public function update():void
		{	
			// check movement input
			if (Input.check(Key.W) || Input.check(Key.UP))          // move up
				y -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.S) || Input.check(Key.DOWN))        // move down
				y += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.A) || Input.check(Key.LEFT))        // move left
				x -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.D) || Input.check(Key.RIGHT))       // move right
				x += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			
			// temp code to keep hero on screen
			if (x < 0) { x = 0; }
			if (x > Global.GAME_WIDTH - width) { x = Global.GAME_WIDTH - width; }
			if (y < 0) { y = 0; }
			if (y > Global.GAME_HEIGHT - height) { y = Global.GAME_HEIGHT - height; }
			
			// check attack input
			if (unlockedAbilities >= 1 && ability1CD <=0 && Input.pressed(Key.DIGIT_1))
				ability1();
			if (unlockedAbilities >= 2 && ability2CD <=0 && Input.pressed(Key.DIGIT_2))
				ability2();
			if (unlockedAbilities >= 3 && ability3CD <=0 && Input.pressed(Key.DIGIT_3))
				ability3();
			
			// update ability cooldown timers
			ability1CD -= FP.elapsed;
			if (ability1CD < 0)
				ability1CD = 0;
			
			if (ability1CD > 0)
				trace("ability 1 cd: " + ability1CD);
			
			ability2CD -= FP.elapsed;
			if (ability2CD < 0)
				ability2CD = 0;
			
			if (ability2CD > 0)
				trace("ability 2 cd: " + ability2CD);
			
			ability3CD -= FP.elapsed;
			if (ability3CD < 0)
				ability3CD = 0;
			
			if (ability3CD > 0)
				trace("ability 3 cd: " + ability3CD);
			
			// check if hero should level up
			if (xp >= Global.XP_TO_LEVEL[level])
			{
				xp -= Global.XP_TO_LEVEL[level];
				level++;
				
				// set appropriate unlocked abilities
				if (level == Global.ABILITY_1_LEVEL)
					unlockedAbilities = 1;
				if (level == Global.ABILITY_2_LEVEL)
					unlockedAbilities = 2;
				if (level == Global.ABILITY_3_LEVEL)
					unlockedAbilities = 3;
			}
		}
		
		public function ability1():void
		{
			trace("Ability 1 used!");
		}
		
		public function ability2():void
		{
			trace("Ability 2 used!");
		}
		
		public function ability3():void
		{
			trace("Ability 3 used!");
		}
	}
}