package towers
{
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class AirTower extends Tower
	{
		
		public function AirTower(x:Number, y:Number)
		{
			super(x, y, Global.AIR_RANGE, Global.AIR_DAMAGE, Global.AIR_SPEED, Global.AIR_CANATTACK, Global.AIR_ARMORPIERCING, "", Global.AIR_TOWERDESCIPT, new TowerUI(centerX, centerY, this));
			type = "air";
			towerImage = new Image(Assets.AIR_TOWER);
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
					range = Global.AIR_RANGE_UPGRADE1;
					damage = Global.AIR_DAMAGE_UPGRADE1;
					speed = Global.AIR_SPEED_UPGRADE1;
					break;
				case 2:
					range = Global.AIR_RANGE_UPGRADE2;
					damage = Global.AIR_DAMAGE_UPGRADE2;
					speed = Global.AIR_SPEED_UPGRADE2;
					special = Global.AIR_SPECIAL;
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
			for each (var enemyType:String in canAttack)
			{
				var enemy:Entity = world.nearestToEntity(enemyType, this);
				if (enemy != null)
				{
					var distToEnemy:Number = Math.sqrt((this.centerX - enemy.centerX) * (this.centerX - enemy.centerX) + ((this.centerY - enemy.centerY) * (this.centerY - enemy.centerY)));
					var distToClosest:Number = Math.sqrt((this.centerX - closestEnemy.centerX) * (this.centerX - closestEnemy.centerX) + (this.centerY - closestEnemy.centerY) * (this.centerY - closestEnemy.centerY));
					
					// Ignore the enemy if it is out of range.
					if (distToEnemy <= this.range)
					{
						if (distToClosest > distToEnemy)
						{
							closestEnemy = enemy;
						}
					}
				}
			}
			
			// Do nothing if there aren't any enemies.
			if (closestEnemy.type != null)
				world.add(new Projectile(centerX, centerY, (Enemy)(closestEnemy), damage, armorPiercing, upgradeCur));
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
				if (Input.mousePressed)
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