package hero
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	import enemies.Enemy;
	
	public class Warrior extends Hero
	{
		import net.flashpunk.graphics.Image;
		
		public function Warrior(startX:Number, startY:Number)
		{
			super(startX, startY);
			
			heroImage = new Image(Assets.WARRIOR);
			graphic = heroImage;
			setHitboxTo(heroImage);
			
			healthArray = Global.WARRIOR_HEALTH_ARRAY;
			attackArray = Global.WARRIOR_ATTACK_ARRAY;
			defenseArray = Global.WARRIOR_DEFENSE_ARRAY;
			speedArray = Global.WARRIOR_SPEED_ARRAY;
			
			maxHealth = healthArray[0];
			currentHealth = maxHealth;
			attack = attackArray[0];
			defense = defenseArray[0];
			speed = speedArray[0];
		}
		
		public override function ability1():void
		{
			super.ability1();
			ability1CD = Global.WARRIOR_ABIL_1_CD;
			
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
							collision = enemy.collideRect(enemy.x, enemy.y, x, y - width, width, width)                 // up
							         || enemy.collideRect(enemy.x, enemy.y, x - width, y - width, width, width)         // left-up
									 || enemy.collideRect(enemy.x, enemy.y, x + width, y - width, width, width);        // right-up
							break;
						case LEFT:
							collision = enemy.collideRect(enemy.x, enemy.y, x - width, y, width, height)                // left
							         || enemy.collideRect(enemy.x, enemy.y, x - width, y - width, width, width)         // left-up
									 || enemy.collideRect(enemy.x, enemy.y, x - width, y + height, width, width);       // left-down
							break;
						case RIGHT:
							collision = enemy.collideRect(enemy.x, enemy.y, x + width, y, width, height)                // right
							         || enemy.collideRect(enemy.x, enemy.y, x + width, y - width, width, width)         // right-up
									 || enemy.collideRect(enemy.x, enemy.y, x + width, y + height, width, width);       // right-down
							break;
						case DOWN:
							collision = enemy.collideRect(enemy.x, enemy.y, x, y + height, width, width)                // down
							         || enemy.collideRect(enemy.x, enemy.y, x - width, y + height, width, width)        // left-down
									 || enemy.collideRect(enemy.x, enemy.y, x + width, y + height, width, width);       // right-down
							break;
						case LEFT_UP:
							collision = enemy.collideRect(enemy.x, enemy.y, x - width, y - width, width, width)         // left-up
							         || enemy.collideRect(enemy.x, enemy.y, x - width, y, width, height)                // left
									 || enemy.collideRect(enemy.x, enemy.y, x, y - width, width, width);                // up
							break;
						case LEFT_DOWN:
							collision = enemy.collideRect(enemy.x, enemy.y, x - width, y + height, width, width)        // left-down
							         || enemy.collideRect(enemy.x, enemy.y, x - width, y, width, height)                // left
									 || enemy.collideRect(enemy.x, enemy.y, x, y + height, width, width);               // down
							break;
						case RIGHT_UP:
							collision = enemy.collideRect(enemy.x, enemy.y, x + width, y - width, width, width)         // right-up
							         || enemy.collideRect(enemy.x, enemy.y, x + width, y, width, height)                // right
									 || enemy.collideRect(enemy.x, enemy.y, x, y - width, width, width);                // up
							break;
						case RIGHT_DOWN:
							collision = enemy.collideRect(enemy.x, enemy.y, x + width, y + height, width, width)        // riht-down
							         || enemy.collideRect(enemy.x, enemy.y, x + width, y, width, height)                // right
									 || enemy.collideRect(enemy.x, enemy.y, x, y + height, width, width);               // down
							break;
						default:
							collision = false;
					}
					
					if (collision)
						(enemy as Enemy).takeDamage(attack, 0, "wheee!");
				}
			}
		}
		
		public override function ability2():void
		{
			super.ability2();
			ability2CD = Global.WARRIOR_ABIL_2_CD;
			
			
		}
		
		public override function ability3():void
		{
			super.ability3();
			ability3CD = Global.WARRIOR_ABIL_3_CD;
			
			
		}
		
		public override function render():void
		{
			super.render();
			
			switch (facing)
			{
				case UP:
					Draw.rectPlus(x, y - width, width, width, 0xFFFFFF, 0.25, true);
					
					Draw.rectPlus(x - width, y - width, width, width, 0xFFFFFF, 0.25, true);
					Draw.rectPlus(x + width, y - width, width, width, 0xFFFFFF, 0.25, true);
					break;
				case LEFT:
					Draw.rectPlus(x - width, y, width, height, 0xFFFFFF, 0.25, true);
					
					Draw.rectPlus(x - width, y - width, width, width, 0xFFFFFF, 0.25, true);
					Draw.rectPlus(x - width, y + height, width, width, 0xFFFFFF, 0.25, true);
					break;
				case RIGHT:
					Draw.rectPlus(x + width, y, width, height, 0xFFFFFF, 0.25, true);
					
					Draw.rectPlus(x + width, y - width, width, width, 0xFFFFFF, 0.25, true);
					Draw.rectPlus(x + width, y + height, width, width, 0xFFFFFF, 0.25, true);
					break;
				case DOWN:
					Draw.rectPlus(x, y + height, width, width, 0xFFFFFF, 0.25, true);
					
					Draw.rectPlus(x - width, y + height, width, width, 0xFFFFFF, 0.25, true);
					Draw.rectPlus(x + width, y + height, width, width, 0xFFFFFF, 0.25, true);
					break;
				case LEFT_UP:
					Draw.rectPlus(x - width, y - width, width, width, 0xFFFFFF, 0.25, true);
					
					Draw.rectPlus(x, y - width, width, width, 0xFFFFFF, 0.25, true);
					Draw.rectPlus(x - width, y, width, height, 0xFFFFFF, 0.25, true);
					break;
				case LEFT_DOWN:
					Draw.rectPlus(x - width, y + height, width, width, 0xFFFFFF, 0.25, true);
					
					Draw.rectPlus(x - width, y, width, height, 0xFFFFFF, 0.25, true);
					Draw.rectPlus(x, y + height, width, width, 0xFFFFFF, 0.25, true);
					break;
				case RIGHT_UP:
					Draw.rectPlus(x + width, y - width, width, width, 0xFFFFFF, 0.25, true);
					
					Draw.rectPlus(x + width, y, width, height, 0xFFFFFF, 0.25, true);
					Draw.rectPlus(x, y - width, width, width, 0xFFFFFF, 0.25, true);
					
					break;
				case RIGHT_DOWN:
					Draw.rectPlus(x + width, y + height, width, width, 0xFFFFFF, 0.25, true);
					
					Draw.rectPlus(x + width, y, width, height, 0xFFFFFF, 0.25, true);
					Draw.rectPlus(x, y + height, width, width, 0xFFFFFF, 0.25, true);
					break;
				default:
			}
		}
	}
}