package towers
{
	import enemies.Enemy;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import ui.BuildButton;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class AirTower extends Tower
	{
		private var towerImage:Image;
		private var timer:Number;
		
		public function AirTower(x:Number, y:Number)
		{
			super(x, y, Global.AIR_RANGE, Global.AIR_DAMAGE, Global.AIR_SPEED, Global.AIR_CANATTACK, Global.AIR_ARMORPIERCING, "", Global.AIR_TOWERDESCIPT, this, Global.AIR_COST, Global.AIR_UPGRADE_COST);
			towerImage = new Image(Assets.AIR_TOWER_1);
			super.graphic = towerImage;
			timer = 0;
			setHitboxTo(towerImage);
		}
		
		override public function upgrade():void
		{
			if (upgradeCur < 2)
				upgradeCur++;
			
			switch (upgradeCur)
			{
				case 1:
					range = Global.AIR_RANGE_UPGRADE1;
					damage = Global.AIR_DAMAGE_UPGRADE1;
					speed = Global.AIR_SPEED_UPGRADE1;
					towerImage = new Image(Assets.AIR_TOWER_2);
					graphic = towerImage;
					break;
				case 2:
					range = Global.AIR_RANGE_UPGRADE2;
					damage = Global.AIR_DAMAGE_UPGRADE2;
					speed = Global.AIR_SPEED_UPGRADE2;
					special = Global.AIR_SPECIAL;
					towerImage = new Image(Assets.AIR_TOWER_3);
					graphic = towerImage;
			}
		}
		
		
		override public function attack():void
		{
			
			var closestEnemy:Entity;
			var secondClosest:Entity;
			
			// Attacks the same enemy until it is dead or out of range.
			if (closestEnemy == null || (Math.sqrt((this.x - closestEnemy.x) * (this.x - closestEnemy.x) + (this.y - closestEnemy.y) * (this.y - closestEnemy.y)) > this.range))
				closestEnemy = null;
			
			if (secondClosest == null || (Math.sqrt((this.x - secondClosest.x) * (this.x - secondClosest.x) + (this.y - secondClosest.y) * (this.y - secondClosest.y)) > this.range))
				secondClosest = null;
				
			// Find closest enemy, check type, attack (keep attack until dead or out of range).
			
			// Finds the closest enemy of any type the tower can attack.
			for each (var enemyType:String in canAttack)
			{
				var enemies:Array = new Array;
				world.getType("flying", enemies);
				
				for each (var enemy:Enemy in enemies)
				{
					if (enemy != null)
					{
						var distToEnemy:Number = Math.sqrt((this.centerX - enemy.centerX) * (this.centerX - enemy.centerX) + ((this.centerY - enemy.centerY) * (this.centerY - enemy.centerY)));
						var distToClosest:Number;
						if (closestEnemy != null)
						{
							distToClosest = Math.sqrt((this.centerX - closestEnemy.centerX) * (this.centerX - closestEnemy.centerX) + (this.centerY - closestEnemy.centerY) * (this.centerY - closestEnemy.centerY));
						}
						else
							distToClosest = Number.MAX_VALUE;
							
						// Ignore the enemy if it is out of range.
						if (distToEnemy <= this.range)
						{
							if (distToClosest > distToEnemy)
							{
								closestEnemy = enemy;
							}
							if (secondClosest == null)
							{
								secondClosest = enemy;
							}
						}
					}
				}
			}
			
			// Do nothing if there aren't any enemies.
			if (closestEnemy != null)
			{
				world.add(new Projectile(centerX, centerY, (Enemy)(closestEnemy), damage, armorPiercing, upgradeCur, Assets.WAVE));
				if ((this.upgradeCur == 2) && (secondClosest != closestEnemy) && (secondClosest != null))
					world.add(new Projectile(centerX, centerY, (Enemy)(secondClosest), damage, armorPiercing, upgradeCur, Assets.WAVE));
			}
		}
	}

}