package hero
{
	import enemies.Enemy;
	import ui.XPBar;
	
	import levels.Egg;
	import levels.Nest;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import ui.CooldownDisplay;
	import ui.HealthBar;
	
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
		
		public var recoverTime:Number;           // remaining invulnerability
		public var isRecovering:Boolean;
		public var blinkCounter:Number;
		
		public var collisionDamagesEnemies:Boolean;
		public var collidedEnemies:Array;
		
		public var facing:Number;
		public var canMove:Boolean;
		
		public var heroImage:Spritemap;              // hero graphic
		
		public var egg:Egg;
		
		protected var healthBar:HealthBar;			// The health bar (duh). 
		protected var xpBar:XPBar;					// The experience bar (also duh).
		protected var cooldown1:CooldownDisplay;
		protected var cooldown2:CooldownDisplay;
		protected var cooldown3:CooldownDisplay;
		
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
			
			recoverTime = Global.HERO_RECOVER_TIME;
			isRecovering = true;
			blinkCounter = 0;
			
			canMove = true;
			collisionDamagesEnemies = false;
			collidedEnemies = new Array();
			
			facing = UP;
			
			//healthBar = new HealthBar(centerX, y, 30, 4, 0);
			//xpBar = new XPBar(centerX, y-healthBar.height, 30, 4, 0);

		}
		
		override public function update():void
		{		
			var collidedEgg:Entity;
			var collidedNest:Entity;
			
			if (canMove)
			{
				/*
				// check movement input
				if (Input.check(Key.W))                                      // move up
					y -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
				if (Input.check(Key.S))                                      // move down
					y += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
				if (Input.check(Key.A))                                      // move left
					x -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
				if (Input.check(Key.D))                                      // move right
					x += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
				*/
				
				if (Input.check(Key.W) && Input.check(Key.A))
				{
					facing = LEFT_UP;
					y -= speed * FP.elapsed * Global.HERO_SPEED_SCALE / Math.SQRT2;
					x -= speed * FP.elapsed * Global.HERO_SPEED_SCALE / Math.SQRT2;
				}
				else if (Input.check(Key.W) && Input.check(Key.D))
				{
					facing = RIGHT_UP;
					y -= speed * FP.elapsed * Global.HERO_SPEED_SCALE / Math.SQRT2;
					x += speed * FP.elapsed * Global.HERO_SPEED_SCALE / Math.SQRT2;
				}
				else if (Input.check(Key.S) && Input.check(Key.A))
				{
					facing = LEFT_DOWN;
					y += speed * FP.elapsed * Global.HERO_SPEED_SCALE / Math.SQRT2;
					x -= speed * FP.elapsed * Global.HERO_SPEED_SCALE / Math.SQRT2;
				}
				else if (Input.check(Key.S) && Input.check(Key.D))
				{
					facing = RIGHT_DOWN;
					y += speed * FP.elapsed * Global.HERO_SPEED_SCALE / Math.SQRT2;
					x += speed * FP.elapsed * Global.HERO_SPEED_SCALE / Math.SQRT2;
				}
				else if (Input.check(Key.W))
				{
					facing = UP;
					y -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
				}
				else if (Input.check(Key.A))
				{
					facing = LEFT;
					x -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
				}
				else if (Input.check(Key.S))
				{
					facing = DOWN;
					y += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
				}
				else if (Input.check(Key.D))
				{
					facing = RIGHT;
					x += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
				}
				
				switch(facing)
				{
					case LEFT:
					case LEFT_UP:
					case LEFT_DOWN:
						heroImage.flipped = true;
						break;
					case RIGHT:
					case RIGHT_UP:
					case RIGHT_DOWN:
						heroImage.flipped = false;
					default:
				}
				
				if (Input.pressed(Key.L))
					gainXP(1);
					
				collidedEgg = collideTypes("egg", x, y);
				if (collidedEgg != null && egg == null && !(collidedEgg as Egg).isCarried) 
				{
					(collidedEgg as Egg).isCarried = true;
					egg = (collidedEgg as Egg);
				}
				
				collidedNest = collideTypes("nest", x, y);
				if (collidedNest != null) 
				{
					currentHealth += FP.elapsed * (maxHealth / 10);
					if (egg != null) 
					{
						(collidedNest as Nest).returnEgg();
						world.remove(egg);
						egg = null;
					}
				}
				
				if (egg != null)
					egg.updatePos(x + width/2, y + height/2);
					
				
				// temp code to keep hero on screen
				if (x < 0) { x = 0; }
				if (x > Global.GAME_WIDTH - width) { x = Global.GAME_WIDTH - width; }
				if (y < 0) { y = 0; }
				if (y > Global.GAME_HEIGHT - height) { y = Global.GAME_HEIGHT - height; }
			}

			// check attack input
			if (unlockedAbilities >= 1 && ability1CD <=0 && Input.pressed(Key.DIGIT_1))
				ability1();
			if (unlockedAbilities >= 2 && ability2CD <=0 && Input.pressed(Key.DIGIT_2))
				ability2();
			if (unlockedAbilities >= 3 && ability3CD <=0 && Input.pressed(Key.DIGIT_3))
				ability3();
			
			
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
			
			recoverTime -= FP.elapsed;
			if (recoverTime < 0)
			{
				isRecovering = false;
				graphic = heroImage;
				recoverTime = 0;
			}
			else
			{
				blinkCounter -= FP.elapsed;
				if (blinkCounter < 0)
				{
					blinkCounter = Global.HERO_BLINK_RATE;
					if (graphic == null)
						graphic = heroImage;
					else
						graphic = null;
				}
			}
			
			// check if hero should level up
			if (level < Global.MAX_LEVELS && xp >= Global.XP_TO_LEVEL[level - 1])
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
			
			for each(var type:String in Global.RANGED_CANATTACK)
			{
				if(!isRecovering)
				{
					var enemy:Entity = collide(type, x, y);
					if (enemy != null && !collisionDamagesEnemies)
					{
						isRecovering = true;
						recoverTime = Global.HERO_RECOVER_TIME;
						blinkCounter = Global.HERO_BLINK_RATE;
						currentHealth -= 1;
						FP.log("Hero hit! Remaining Health: " + currentHealth);
						
						if (currentHealth == 0)
						{
							world.remove(this);
						}
					}
					else if (enemy != null && collisionDamagesEnemies)
					{
						var shouldDamage:Boolean = true;
						for each (var entity:Entity in collidedEnemies)
						{
							if (entity == enemy)
								shouldDamage = false;
						}
						if (shouldDamage)
						{
							(enemy as Enemy).takeDamage(attack, 0, "probably dashing!");
							collidedEnemies.push(enemy);
						}
					}
				}
			}
						
			// Prevents multiple health bars from being made
			if (healthBar.name == null)
			{
				healthBar.name = "done";
				world.add(healthBar);
			}
			else
			{
				// Updates location of healtbar so it moves with the entity.
				healthBar.updateVal(centerX, this.y, currentHealth/maxHealth);
			}
			
			
			// Prevents multiple xp bars for being made
			if (xpBar.name == null)
			{
				xpBar.name = "done";
				world.add(xpBar);
			}
			else
			{
				// Updates location of healtbar so it moves with the entity.
				xpBar.updateVal(centerX, this.y + 4, xp/Global.XP_TO_LEVEL[level - 1]);
			}
			
			if (cooldown1.name == null)
			{
				cooldown1.name = "done";
				world.add(cooldown1);
				world.add(cooldown2);
				world.add(cooldown3);
			}
			else
			{
				// Updates location of healtbar so it moves with the entity.
				cooldown1.updateVal(this.ability1CD / Global.WARRIOR_ABIL_1_CD);
				cooldown2.updateVal(this.ability2CD / Global.WARRIOR_ABIL_2_CD);
				cooldown3.updateVal(this.ability3CD/Global.WARRIOR_ABIL_3_CD);
			}
		}
		
		public override function render():void
		{
			super.render();
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
		
		public function gainXP(toGain:Number):void
		{
			if (level < Global.MAX_LEVELS)
				xp += toGain;
		}
	}
}