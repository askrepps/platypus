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
		
		public var clicked:Boolean;
		
		public function Warrior(startX:Number, startY:Number)
		{
			super(startX, startY);
			
			heroImage = new Spritemap(Assets.WARRIOR, 100, 100);
			setupSprites(heroImage);
			graphic = heroImage;
			setHitboxTo(heroImage);
			
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
			
			
			super.cooldown1 = new CooldownDisplay(100, FP.screen.height - 120, ability1CD / Global.WARRIOR_ABIL_1_CD, ability1);
			super.cooldown2 = new CooldownDisplay(150, FP.screen.height - 120, ability2CD / Global.WARRIOR_ABIL_2_CD, ability2);
			super.cooldown3 = new CooldownDisplay(200, FP.screen.height - 120, ability3CD/Global.WARRIOR_ABIL_3_CD, ability3);
			
			heroImage.play("walking");
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
				collisionDamagesEnemies = false;
				isRecovering = true;
				recoverTime = Global.HERO_RECOVER_TIME;
				heroImage.play("walking");
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
				if (distanceToPoint(leapX - width/2, leapY - height/2) > Global.WARRIOR_LEAP_SPEED)
				{
					moveTowards(leapX - width/2, leapY - height/2, Global.WARRIOR_LEAP_SPEED);
				}
				else
				{
					x = leapX - width/2;
					y = leapY - height/2;
					isLeaping = false;
					canMove = true;
					isRecovering = true;
					heroImage.play("walking");
					recoverTime = Global.HERO_RECOVER_TIME;
					
					var entities:Array = new Array();
					var collision:Boolean;
					world.getAll(entities);
					
					for each(var enemy:Entity in entities)
					{
						if (enemy is Enemy)
						{
							if(distanceFrom(enemy) < Global.WARRIOR_LEAP_ATTACK_RANGE)
								(enemy as Enemy).takeDamage(attack, 0, "stunned?");
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
					
					if (distanceToPoint(world.mouseX - width/2, world. mouseY - height/2) < leapRange)
					{
						isLeaping = true;
						canMove = false;
						heroImage.play("dashing");
						ability2CD = Global.WARRIOR_ABIL_2_CD;
						leapX = world.mouseX;
						leapY = world.mouseY;
					}
				}
			}
		}
		
		public override function ability1():void
		{
			if (ability1CD <= 0)
			{
				super.ability1();
				ability1CD = Global.WARRIOR_ABIL_1_CD;
				
				var entities:Array = new Array();
				var collision:Boolean;
				world.getAll(entities);
				
				heroImage.setAnimFrame("attack", 0);
				heroImage.play("attack");
				
				
				for each(var enemy:Entity in entities)
				{
					if (enemy is Enemy)
					{
						switch (facing)
						{
							case UP:
								collision = enemy.collideRect(enemy.x, enemy.y, x, y - height/4, width, height/2);
								break;
							case LEFT:
								collision = enemy.collideRect(enemy.x, enemy.y, x - width/4, y, width/2, height);
								break;
							case RIGHT:
								collision = enemy.collideRect(enemy.x, enemy.y, x + width - width/4, y, width/2, height);
								break;
							case DOWN:
								collision = enemy.collideRect(enemy.x, enemy.y, x, y + height - height/4, width, height/2);
								break;
							case LEFT_UP:
								collision = enemy.collideRect(enemy.x, enemy.y, x - width/4, y, width/2, height*0.6)         // left-up
										 || enemy.collideRect(enemy.x, enemy.y, x, y - height/4, width*0.6, height/2)                // left
										 || enemy.collideRect(enemy.x, enemy.y, x - width/4, y - height/4, width/4, height/4);                // up
								break;
							case LEFT_DOWN:
								collision = enemy.collideRect(enemy.x, enemy.y, x - width/4, y + height*0.4, width/2, height*0.6)        // left-down
										 || enemy.collideRect(enemy.x, enemy.y, x, y + height - height/4, width*0.6, height/2)                // left
										 || enemy.collideRect(enemy.x, enemy.y, x - width/4, y + height, width/4, height/4);               // down
								break;
							case RIGHT_UP:
								collision = enemy.collideRect(enemy.x, enemy.y, x + width - width/4, y, width/2, height*0.6)         // right-up
										 || enemy.collideRect(enemy.x, enemy.y, x + width*0.4, y - height/4, width*0.6, height/2)                // right
										 || enemy.collideRect(enemy.x, enemy.y, x + width, y - height/4, width/4, height/4);                // up
								break;
							case RIGHT_DOWN:
								collision = enemy.collideRect(enemy.x, enemy.y, x + width - width/4, y + height*0.4, width/2, height*0.6)        // riht-down
										 || enemy.collideRect(enemy.x, enemy.y, x + width*0.4, y + height - height/4, width*0.6, height/2)                // right
										 || enemy.collideRect(enemy.x, enemy.y, x + width, y + height, width/4, height/4);               // down
								break;
							default:
								collision = false;
						}
						
						if (collision)
							(enemy as Enemy).takeDamage(attack, 0, "wheee!");
					}
				}
			}
		}
		
		public override function ability2():void
		{
			if (ability2CD <= 0)
			{
				super.ability2();
				
				isLeapTargeting = true;
			}
		}
		
		public override function ability3():void
		{
			if (ability3CD <= 0)
			{
				super.ability3();
				ability3CD = Global.WARRIOR_ABIL_3_CD;
				
				collidedEnemies = new Array();
				isDashing = true;
				dashTime = Global.WARRIOR_DASH_TIME;
				canMove = false;
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
						Draw.rectPlus(x, y - height/4, width, height/2, 0xFFFFFF, 0.25, true);
						break;
					case LEFT:
						Draw.rectPlus(x - width/4, y, width/2, height, 0xFFFFFF, 0.25, true);
						break;
					case RIGHT:
						Draw.rectPlus(x + width - width/4, y, width/2, height, 0xFFFFFF, 0.25, true);
						break;
					case DOWN:
						Draw.rectPlus(x, y + height - height/4, width, height/2, 0xFFFFFF, 0.25, true);
						break;
					case LEFT_UP:
						Draw.rectPlus(x - width/4, y, width/2, height*0.6, 0xFFFFFF, 0.25, true);                          // some left
						Draw.rectPlus(x, y - height/4, width*0.6, height/2, 0xFFFFFF, 0.25, true);                         // some up
						
						Draw.rectPlus(x - width/4, y - height/4, width/4, height/4, 0xFFFFFF, 0.25, true);                 // filler
						break;
					case LEFT_DOWN:
						Draw.rectPlus(x - width/4, y + height*0.4, width/2, height*0.6, 0xFFFFFF, 0.25, true);             // some left
						Draw.rectPlus(x, y + height - height/4, width*0.6, height/2, 0xFFFFFF, 0.25, true);                // some down
						
						Draw.rectPlus(x - width/4, y + height, width/4, height/4, 0xFFFFFF, 0.25, true);                   // filler
						break;
					case RIGHT_UP:
						Draw.rectPlus(x + width - width/4, y, width/2, height*0.6, 0xFFFFFF, 0.25, true);                  // some right
						Draw.rectPlus(x + width*0.4, y - height/4, width*0.6, height/2, 0xFFFFFF, 0.25, true);             // some up
						
						Draw.rectPlus(x + width, y - height/4, width/4, height/4, 0xFFFFFF, 0.25, true);                   // filler
						break;
					case RIGHT_DOWN:
						Draw.rectPlus(x + width - width/4, y + height*0.4, width/2, height*0.6, 0xFFFFFF, 0.25, true);     // some right
						Draw.rectPlus(x + width*0.4, y + height - height/4, width*0.6, height/2, 0xFFFFFF, 0.25, true);    // some down
						
						Draw.rectPlus(x + width, y + height, width/4, height/4, 0xFFFFFF, 0.25, true);                     // filler
						break;
					default:
				}
			}
			
			if (isLeapTargeting)
			{
				Draw.circlePlus(x + width/2, y + height/2, leapRange, 0xFFFFFF, 0.25, true);
			}
			
			
		}
		
		public function setupSprites(spriteMap:Spritemap):void
		{
			spriteMap.add("walking", [0], 0, false);
			spriteMap.add("attack", [0, 1, 2, 1, 0], 10, false);
			spriteMap.add("dashing", [2], 0, false);
		}
	}
}