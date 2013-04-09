package towers 
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import enemies.Enemy;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class RangedTower extends Entity 
	{			
		private var towerImage:Image;
		private var timer:Number;
		public var range:Number;			// Pixel range the tower can hit.
		public var damage:Number;			// Damage the tower does per hit.
		public var speed:Number;			// Num of attacks per second.
		public var canAttack:Array; 		// Array of strings that holds the type of enemies the tower can hit.
		public var upgradeCur:Number;		// Current upgrade level.
		public var armorPiercing:Number;  	// Percentage of armor ignored by attacks.
		public var special:String;			// Special effect from attack (e.g. slow, stun, etc.)
		public var towerDescipt:String;
		
		public function RangedTower(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
			range = Global.RANGED_RANGE;
			damage = Global.RANGED_DAMAGE;
			speed = Global.RANGED_SPEED;
			canAttack = Global.RANGED_CANATTACK;
			armorPiercing = Global.RANGED_ARMORPIERCING;
			special = Global.RANGED_SPECIAL;
			towerDescipt = Global.RANGED_TOWERDESCIPT;
			type = "ranged";
			towerImage = new Image(Assets.RANGED_TOWER);
			graphic = towerImage;
			timer = 0;
			setHitboxTo(towerImage);
		}
		
		public function attack():void
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
				(Enemy)(closestEnemy).takeDamage(this.damage, this.armorPiercing, this.special);
		}
		
		public function test():void
		{
			trace("This is a test");
		}
		
		override public function update():void
		{
			timer++;
			
			if (timer >= speed)
			{
				timer = 0;
				attack();
			}
			
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				if(Input.mousePressed)
					world.add(new TowerUI(centerX, centerY));
			}
			
			super.update();
		}
	}

}