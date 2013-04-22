package hero
{
	import enemies.Enemy;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	
	import ui.CooldownDisplay;
	import ui.HealthBar;
	import ui.XPBar;
	
	public class Warrior extends Hero
	{
		public var isDashing:Boolean;
		public var dashTime:Number;
		public var dashSpeed:Number;
		
		public var isLeapTargeting:Boolean;
		public var isLeaping:Boolean;
		public var leapRange:Number;
		public var leapX:Number;
		public var leapY:Number;
		public var drawLanding:Boolean;
		
		public var clicked:Boolean;
		
		public function Warrior(startX:Number, startY:Number)
		{
			super(startX, startY);
			
			heroImage = new Spritemap(Assets.WARRIOR, 100, 100);
			setupSprites();
			graphic = heroImage;
			setHitbox(50, 60, -25, -25);
			
			healthBar = new HealthBar(centerX, y, 30, 4, 0);
			xpBar = new XPBar(centerX, y-healthBar.height, 30, 4, 0);
			
			healthArray = Global.WARRIOR_HEALTH_ARRAY;
			attackArray = Global.WARRIOR_ATTACK_ARRAY;
			defenseArray = Global.WARRIOR_DEFENSE_ARRAY;
			speedArray = Global.WARRIOR_SPEED_ARRAY;
			
			dashSpeed = Global.WARRIOR_DASH_SPEED;
			dashTime = 0;
			isDashing = false;
			
			leapRange = Global.WARRIOR_LEAP_RANGE;
			isLeapTargeting = false;
			clicked = false;
			
			maxHealth = healthArray[0];
			currentHealth = maxHealth;
			attack = attackArray[0];
			defense = defenseArray[0];
			speed = speedArray[0];
			
			
			super.cooldown1 = new CooldownDisplay(FP.screen.width/2 - 100, FP.screen.height - 120, ability1CD / Global.WARRIOR_ABIL_1_CD, "Cleave",ability1);
			super.cooldown2 = new CooldownDisplay(FP.screen.width/2 - 30, FP.screen.height - 120, ability2CD / Global.WARRIOR_ABIL_2_CD, "Jump",ability2);
			super.cooldown3 = new CooldownDisplay(FP.screen.width/2 + 40, FP.screen.height - 120, ability3CD / Global.WARRIOR_ABIL_3_CD, "Dash", ability3);
			
			heroImage.setAnimFrame("walking", 0);
		}
		
		public override function update():void
		{
			super.update();
			
			if (dashTime > 0)
				dashTime -= FP.elapsed;
			if (dashTime < 0)
			{
				dashTime = 0;
				isDashing = false;
				canMove = true;
				isAttacking = false;
				collisionDamagesEnemies = false;
				isRecovering = true;
				isVulnerable = true;
				recoverTime = Global.HERO_RECOVER_TIME;
			}
			else if (isDashing)
			{
				switch(facing)
				{
					case UP:
						y -= dashSpeed;
						break;
					case LEFT:
						x -= dashSpeed;
						break;
					case RIGHT:
						x += dashSpeed;
						break;
					case DOWN:
						y += dashSpeed;
						break;
					case LEFT_UP:
						x -= dashSpeed / Math.SQRT2;
						y -= dashSpeed / Math.SQRT2;
						break;
					case RIGHT_UP:
						x += dashSpeed / Math.SQRT2;
						y -= dashSpeed / Math.SQRT2;
						break;
					case LEFT_DOWN:
						x -= dashSpeed / Math.SQRT2;
						y += dashSpeed / Math.SQRT2;
						break;
					case RIGHT_DOWN:
						x += dashSpeed / Math.SQRT2;
						y += dashSpeed / Math.SQRT2;
						break;
					default:
				}
			}
			
			if (isLeaping)
			{
				if (distance(leapX - width/2, leapY - height/2, x + 25, y + 25) > Global.WARRIOR_LEAP_SPEED)
				{
					moveTowards(leapX - width/2 - 25, leapY - height/2 - 25, Global.WARRIOR_LEAP_SPEED);
				}
				else
				{
					x = leapX - width/2 - 25;
					y = leapY - height/2 - 25;
					isLeaping = false;
					canMove = true;
					isRecovering = true;
					isAttacking = false;
					isVulnerable = true;
					drawLanding = true;
					recoverTime = Global.HERO_RECOVER_TIME;
					
					var entities:Array = new Array();
					var collision:Boolean;
					world.getAll(entities);
					
					for each(var enemy:Entity in entities)
					{
						if (enemy is Enemy)
						{
							if(distanceFrom(enemy) < Global.WARRIOR_LEAP_ATTACK_RANGE)
							{
								(enemy as Enemy).takeDamage(attack, 0, "stunned?");
								(enemy as Enemy).slow(5, 0.5);
							}
						}
					}
				}
			}
			
			if (isLeapTargeting)
			{
				if (Input.mousePressed)
					clicked = true;
				if (clicked && Input.mouseReleased)
				{
					clicked = false;
					isLeapTargeting = false;
					
					if (distance(world.mouseX - width/2, world. mouseY - height/2, x + 25, y + 25) < leapRange)
					{
						isLeaping = true;
						canMove = false;
						isAttacking = true;
						isVulnerable = false;
						drawLanding = false;
						heroImage.play("dashing");
						ability2CD = Global.WARRIOR_ABIL_2_CD;
						leapX = world.mouseX;
						leapY = world.mouseY;
					}
				}
			}
			
			if (!isAttacking)
			{
				if (isMoving)
					heroImage.play("walking");
				else
					heroImage.setAnimFrame("walking", 0);
			}
		}
		
		public override function ability1():void
		{
			if (unlockedAbilities >= 1 && ability1CD <= 0)
			{
				super.ability1();
				ability1CD = Global.WARRIOR_ABIL_1_CD;
				
				var entities:Array = new Array();
				var collision:Boolean;
				world.getAll(entities);
				
				isAttacking = true;
				heroImage.setAnimFrame("attack", 0);
				heroImage.play("attack");
				
				
				for each(var enemy:Entity in entities)
				{
					if (enemy is Enemy)
					{
						switch (facing)
						{
							case UP:
								collision = enemy.collideRect(enemy.x, enemy.y, x, y - 25, 100, 50);
								break;
							case LEFT:
								collision = enemy.collideRect(enemy.x, enemy.y, x - 25, y, 50, 100);
								break;
							case RIGHT:
								collision = enemy.collideRect(enemy.x, enemy.y, x + 75, y, 50, 100);
								break;
							case DOWN:
								collision = enemy.collideRect(enemy.x, enemy.y, x, y + 75, 100, 50);
								break;
							case LEFT_UP:
								collision = enemy.collideRect(enemy.x, enemy.y, x - 25, y, 50, 60)         // left-up
										 || enemy.collideRect(enemy.x, enemy.y, x, y - 25, 60, 50)         // left
										 || enemy.collideRect(enemy.x, enemy.y, x - 25, y - 25, 25, 25);   // up
								break;
							case LEFT_DOWN:
								collision = enemy.collideRect(enemy.x, enemy.y, x - 25, y + 40, 50, 60)    // left-down
										 || enemy.collideRect(enemy.x, enemy.y, x, y + 75, 60, 50)         // left
										 || enemy.collideRect(enemy.x, enemy.y, x - 25, y + 100, 25, 25);  // down
								break;
							case RIGHT_UP:
								collision = enemy.collideRect(enemy.x, enemy.y, x + 75, y, 50, 60)         // right-up
										 || enemy.collideRect(enemy.x, enemy.y, x + 40, y - 25, 60, 50)    // right
										 || enemy.collideRect(enemy.x, enemy.y, x + 100, y - 25, 25, 25);  // up
								break;
							case RIGHT_DOWN:
								collision = enemy.collideRect(enemy.x, enemy.y, x + 75, y + 40, 50, 60)    // right-down
										 || enemy.collideRect(enemy.x, enemy.y, x + 40, y + 75, 60, 50)    // right
										 || enemy.collideRect(enemy.x, enemy.y, x + 100, y + 100, 25, 25); // down
								break;
							default:
								collision = false;
						}
						
						if (collision)
						{
							(enemy as Enemy).attackedByHero = true;
							(enemy as Enemy).takeDamage(attack, 0, "wheee!");
						}
					}
				}
			}
		}
		
		public override function ability2():void
		{
			if (unlockedAbilities >= 2 && ability2CD <= 0)
			{
				super.ability2();
				
				isLeapTargeting = true;
			}
		}
		
		public override function ability3():void
		{
			if (unlockedAbilities >= 3 && ability3CD <= 0)
			{
				super.ability3();
				ability3CD = Global.WARRIOR_ABIL_3_CD;
				
				collidedEnemies = new Array();
				isDashing = true;
				isAttacking = true;
				dashTime = Global.WARRIOR_DASH_TIME;
				canMove = false;
				isVulnerable = false;
				collisionDamagesEnemies = true;
				
				heroImage.play("dashing");
			}
		}
		
		public override function render():void
		{
			super.render();
			
			if (ability1CD > 0)
			{
				switch (facing)
				{
					case UP:
						Draw.rectPlus(x, y - 25, 100, 50, 0xFF0000, 0.25, true);
						break;
					case LEFT:
						Draw.rectPlus(x - 25, y, 50, 100, 0xFF0000, 0.25, true);
						break;
					case RIGHT:
						Draw.rectPlus(x + 75, y, 50, 100, 0xFF0000, 0.25, true);
						break;
					case DOWN:
						Draw.rectPlus(x, y + 75, 100, 50, 0xFF0000, 0.25, true);
						break;
					case LEFT_UP:
						Draw.rectPlus(x - 25, y + 25, 50, 35, 0xFF0000, 0.25, true);       // some left
						Draw.rectPlus(x - 25, y - 25, 85, 50, 0xFF0000, 0.25, true);       // some up
						break;
					case LEFT_DOWN:
						Draw.rectPlus(x - 25, y + 40, 50, 35, 0xFF0000, 0.25, true);       // some left
						Draw.rectPlus(x - 25, y + 75, 85, 50, 0xFF0000, 0.25, true);       // some down
						break;
					case RIGHT_UP:
						Draw.rectPlus(x + 75, y + 25, 50, 35, 0xFF0000, 0.25, true);       // some right
						Draw.rectPlus(x + 40, y - 25, 85, 50, 0xFF0000, 0.25, true);       // some up
						break;
					case RIGHT_DOWN:
						Draw.rectPlus(x + 75, y + 40, 50, 35, 0xFF0000, 0.25, true);       // some right
						Draw.rectPlus(x + 40, y + 75, 85, 50, 0xFF0000, 0.25, true);       // some down
						break;
					default:
				}
			}
			
			if (isLeapTargeting)
			{
				Draw.circlePlus(x + width/2 + 25, y + height/2 + 25, leapRange, 0xFFFFFF, 0.25, true);
			}
			
			if (drawLanding && ability2CD > (Global.WARRIOR_ABIL_2_CD - 0.5))
			{
				Draw.circlePlus(leapX, leapY, Global.WARRIOR_LEAP_ATTACK_RANGE, 0xFF0000, 0.25);
			}
		}
		
		public function setupSprites():void
		{
			heroImage.add("walking", [0, 1, 2, 3], 5, true);
			heroImage.add("attack", [4, 5, 6, 5, 4], 10, false);
			heroImage.add("dashing", [6], 0, false);
		}
		
		private function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return Math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
		}
	}
}