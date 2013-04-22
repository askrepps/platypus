package towers 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import enemies.Enemy;
	import net.flashpunk.graphics.Image;
	import ui.BuildButton;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class MeleeTower extends Tower 
	{
		private var towerImage:Image;
		private var timer:Number;
		
		public function MeleeTower(x:Number, y:Number) 
		{
			super(x, y, Global.MELEE_RANGE, Global.MELEE_DAMAGE, Global.MELEE_SPEED, Global.MELEE_CANATTACK, Global.MELEE_ARMORPIERCING, "", Global.MELEE_TOWERDESCIPT, this,  Global.MELEE_COST, Global.MELEE_UPGRADE_COST);
			towerImage = new Image(Assets.MELEE_TOWER_1);
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
					range = Global.MELEE_RANGE_UPGRADE1;
					damage = Global.MELEE_DAMAGE_UPGRADE1;
					speed = Global.MELEE_SPEED_UPGRADE1;
					towerImage = new Image(Assets.MELEE_TOWER_2);
					graphic = towerImage;
					break;
				case 2:
					range = Global.MELEE_RANGE_UPGRADE2;
					damage = Global.MELEE_DAMAGE_UPGRADE2;
					speed = Global.MELEE_SPEED_UPGRADE2;
					special = Global.MELEE_SPECIAL;
					towerImage = new Image(Assets.MELEE_TOWER_3);
					graphic = towerImage;
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
				var enemy:Entity = world.nearestToEntity(enemyType, this, true);
				
				if (enemy != null)
				{
					var distToEnemy:Number = Math.sqrt((this.x - enemy.x) * (this.x - enemy.x) + ((this.y - enemy.y) * (this.y - enemy.y)));
					var distToClosest:Number = Math.sqrt((this.x - closestEnemy.x) * (this.x - closestEnemy.x) + (this.y - closestEnemy.y) * (this.y - closestEnemy.y));
					
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
				(Enemy)(closestEnemy).takeDamage(this.damage, this.armorPiercing, this.special);
		}
	}
}