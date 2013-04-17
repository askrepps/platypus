package hero
{
	import net.flashpunk.Entity;
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
		
		public override function basicAttack():void
		{
			super.basicAttack();
			basicCD = Global.WARRIOR_BASIC_CD;
		}
	}
}