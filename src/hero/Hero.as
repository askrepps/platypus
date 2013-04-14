package hero
{
	import enemies.Enemy;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Hero extends Entity
	{
		public static const LEFT:Number = 1;
		public static const LEFT_UP:Number = 2;
		public static const UP:Number = 3;
		public static const RIGHT_UP:Number = 4;
		public static const RIGHT:Number = 5;
		public static const RIGHT_DOWN:Number = 6;
		public static const DOWN:Number = 7;
		public static const LEFT_DOWN:Number = 8;
		
		public var maxHealth:Number;             // max health
		public var currentHealth:Number;         // current health
		public var attack:Number;                // attack power
		public var defense:Number;               // defense
		public var speed:Number;                 // maximum speed
		
		public var healthArray:Array;            // max health at each level
		public var attackArray:Array;            // attack at each level
		public var defenseArray:Array;           // defense at each level
		public var speedArray:Array;             // speed at each level
		
		public var level:Number;                 // current level
		public var xp:Number;                    // current experience points
		public var unlockedAbilities:Number;     // number of abilities available
		
		public var ability1CD:Number;            // remaining cooldown on ability 1
		public var ability2CD:Number;            // remaining cooldown on ability 2
		public var ability3CD:Number;            // remaining cooldown on ability 3
		public var basicCD:Number;               // remaining cooldown on basic attacks
		
		public var facing:Number;
		
		public var heroImage:Image;              // hero graphic
		
		public function Hero(startX:Number, startY:Number) 
		{
			x = startX;
			y = startY;
			type = "hero";
			
			level = 1;
			xp = 0;
			unlockedAbilities = 3;       // all abilities unlocked for testing
			ability1CD = 0;
			ability2CD = 0;
			ability3CD = 0;
			basicCD = 0;
			
			facing = UP;
		}
		
		override public function update():void
		{	
			// check movement input
			if (Input.check(Key.W))                                      // move up
				y -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.S))                                      // move down
				y += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.A))                                      // move left
				x -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.D))                                      // move right
				x += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			
			if (Input.check(Key.W) && Input.check(Key.A))
				facing = LEFT_UP;
			else if (Input.check(Key.W) && Input.check(Key.D))
				facing = RIGHT_UP;
			else if (Input.check(Key.S) && Input.check(Key.A))
				facing = LEFT_DOWN;
			else if (Input.check(Key.S) && Input.check(Key.D))
				facing = RIGHT_DOWN;
			else if (Input.check(Key.W))
				facing = UP;
			else if (Input.check(Key.A))
				facing = LEFT;
			else if (Input.check(Key.S))
				facing = DOWN;
			else if (Input.check(Key.D))
				facing = RIGHT;
			
			if (Input.pressed(Key.L))
				gainXP(1);
				
			
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
			
			if (basicCD <= 0 && Input.pressed(Key.SPACE))
				basicAttack();
			
			// update ability cooldown timers
			basicCD -= FP.elapsed;
			if (basicCD < 0)
				basicCD = 0;
			
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
			if (level <= Global.MAX_LEVELS && xp >= Global.XP_TO_LEVEL[level - 1])
			{
				xp -= Global.XP_TO_LEVEL[level];
				level++;
				FP.log("Hero reached level " + level + "!");
				
				maxHealth = healthArray[level - 1];
				currentHealth = maxHealth;
				attack = attackArray[level - 1];
				defense = defenseArray[level - 1];
				speed = speedArray[level - 1];
				
				// set appropriate unlocked abilities
				if (level == Global.ABILITY_1_LEVEL)
					unlockedAbilities = 1;
				if (level == Global.ABILITY_2_LEVEL)
					unlockedAbilities = 2;
				if (level == Global.ABILITY_3_LEVEL)
					unlockedAbilities = 3;
			}
		}
		
		public override function render():void
		{
			super.render();
			
			switch (facing)
			{
				case UP:
					Draw.rectPlus(x, y - width, width, width, 0xFFFFFF, 0.25, true);
					break;
				case LEFT:
					Draw.rectPlus(x - width, y + 0.25*height, width, width, 0xFFFFFF, 0.25, true);
					break;
				case RIGHT:
					Draw.rectPlus(x + width, y + 0.25*height, width, width, 0xFFFFFF, 0.25, true);
					break;
				case DOWN:
					Draw.rectPlus(x, y + height, width, width, 0xFFFFFF, 0.25, true);
					break;
				case LEFT_UP:
					Draw.rectPlus(x - width, y - width, width, width, 0xFFFFFF, 0.25, true);
					break;
				case LEFT_DOWN:
					Draw.rectPlus(x - width, y + height, width, width, 0xFFFFFF, 0.25, true);
					break;
				case RIGHT_UP:
					Draw.rectPlus(x + width, y - width, width, width, 0xFFFFFF, 0.25, true);
					break;
				case RIGHT_DOWN:
					Draw.rectPlus(x + width, y + height, width, width, 0xFFFFFF, 0.25, true);
					break;
				default:
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
		
		public function basicAttack():void
		{
			trace("Basic Attack!");
			
			var entities:Array = new Array();
			var collision:Boolean;
			world.getAll(entities);
			
			for each(var enemy:Entity in entities)
			{
				if (enemy is Enemy)
				{
					switch (facing)
					{
						case UP:
							collision = enemy.collideRect(enemy.x, enemy.y, x, y - width, width, width);
							break;
						case LEFT:
							collision = enemy.collideRect(enemy.x, enemy.y, x - width, y + 0.25*height, width, width);
							break;
						case RIGHT:
							collision = enemy.collideRect(enemy.x, enemy.y, x + width, y + 0.25*height, width, width);
							break;
						case DOWN:
							collision = enemy.collideRect(enemy.x, enemy.y, x, y + height, width, width);
							break;
						case LEFT_UP:
							collision = enemy.collideRect(enemy.x, enemy.y, x - width, y - width, width, width);
							break;
						case LEFT_DOWN:
							collision = enemy.collideRect(enemy.x, enemy.y, x - width, y + height, width, width);
							break;
						case RIGHT_UP:
							collision = enemy.collideRect(enemy.x, enemy.y, x + width, y - width, width, width);
							break;
						case RIGHT_DOWN:
							collision = enemy.collideRect(enemy.x, enemy.y, x + width, y + height, width, width);
							break;
						default:
							collision = false;
					}
					
					if (collision)
						(enemy as Enemy).takeDamage(attack, 0, "wheee!");
				}
			}
		}
		
		public function gainXP(toGain:Number):void
		{
			xp += toGain;
		}
	}
}