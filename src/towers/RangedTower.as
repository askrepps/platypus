package towers 
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import enemies.Enemy;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class RangedTower extends Tower
	{	
		
		private var towerImage:Image;
		private var timer:Number;
		private static var towerUI:TowerUI;

		public function RangedTower(x:Number, y:Number)
		{
			super(x, y, Global.RANGED_RANGE, Global.RANGED_DAMAGE, Global.RANGED_SPEED, Global.RANGED_CANATTACK, Global.RANGED_ARMORPIERCING, "", Global.RANGED_TOWERDESCIPT);
			type = "ranged";
			towerImage = new Image(Assets.RANGED_TOWER);
			super.graphic = towerImage;
			timer = 0;
			setHitboxTo(towerImage);
			towerUI = new TowerUI(centerX, centerY, this);
		}
		
		public function upgrade():void
		{
			if (upgradeCur < 2)
				upgradeCur++;
			
			switch (upgradeCur)
			{
				case 1:
					range = Global.RANGED_RANGE_UPGRADE1;
					damage = Global.RANGED_DAMAGE_UPGRADE1;
					speed = Global.RANGED_SPEED_UPGRADE1;
					break;
				case 2:
					range = Global.RANGED_RANGE_UPGRADE2;
					damage = Global.RANGED_DAMAGE_UPGRADE2;
					speed = Global.RANGED_SPEED_UPGRADE2;
					special = Global.RANGED_SPECIAL;
					towerDescipt = "A highly powerful melee tower. Due to the totally-non-copyright-infringing lightsword it ignores unit armor!"
			}
		}
		
		
		override public function attack():void
		{
			
			
			var closestEnemy:Entity;
			
			// Attacks the same enemy until it is dead or out of range.
			if (closestEnemy == null || (Math.sqrt((this.x - closestEnemy.x) * (this.x - closestEnemy.x) + (this.y - closestEnemy.y) * (this.y - closestEnemy.y)) > this.range))
				closestEnemy = new Entity(FP.screen.width, FP.screen.height);

			// Find closest enemy, check type, attack (keep attack until dead or out of range).
		
			// Finds the closest enemy of any type the tower can attack.
			for each(var enemyType:String in canAttack)
			{
				var enemy:Entity = world.nearestToEntity(enemyType, this);
				if (enemy != null)
				{
					var distToEnemy:Number = Math.sqrt((this.centerX - enemy.centerX) * (this.centerX - enemy.centerX) + ((this.centerY - enemy.centerY) * (this.centerY - enemy.centerY)));
					var distToClosest:Number = Math.sqrt((this.centerX - closestEnemy.centerX) * (this.centerX - closestEnemy.centerX) + (this.centerY - closestEnemy.centerY) * (this.centerY - closestEnemy.centerY));
					
					// Ignore the enemy if it is out of range.
					if(distToEnemy <= this.range)
					{
						if(distToClosest > distToEnemy)
						{
							closestEnemy = enemy;
						}
					}
				}
			}
			
			// Do nothing if there aren't any enemies.
			if(closestEnemy.type != null)
				world.add(new Projectile(x, y, (Enemy)(closestEnemy), damage, armorPiercing, upgradeCur));
			//(Enemy)(closestEnemy).takeDamage(this.damage, this.armorPiercing, this.special); 
		}
		
		public function test():void
		{
			trace("This is a test");
		}
		
		override public function update():void
		{
			timer += FP.elapsed;
			
			if (timer >= speed)
			{
				timer = 0;
				attack();
			}
			
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				if(Input.mousePressed)
					world.add(towerUI);
			}
			
			if (Input.pressed(Key.U))
			{
				upgrade();
			}
			
			super.update();
		}
	}

}