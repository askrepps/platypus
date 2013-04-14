package towers 
{
	import enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * "Abstract" class that is the base for all tower types.
	 * @author Jonathan Benkovic
	 */
	public class Tower extends Entity 
	{
		public var range:Number;			// Pixel range the tower can hit.
		public var damage:Number;			// Damage the tower does per hit.
		public var speed:Number;			// Num of attacks per second.
		public var canAttack:Array; 		// Array of strings that holds the type of enemies the tower can hit.
		public var upgradeCur:Number;		// Current upgrade level.
		public var armorPiercing:Number;  	// Percentage of armor ignored by attacks.
		public var special:String;			// Special effect from attack (e.g. slow, stun, etc.)
		public var towerDescipt:String;
		
		// Constructor for default tower.
/*		public function Tower()
		{
			this.upgradeCur = 0;
		}
*/		
		public function Tower(x:Number, y:Number, range:Number, damage:Number, speed:Number, canAttack:Array, armorPiercing:Number, special:String, towerDescript:String)
		{
			this.x = x;
			this.y = y;
			this.range = range;
			this.damage = damage;
			this.speed = speed;
			this.canAttack = canAttack;
			this.upgradeCur = 0;			// All towers start at base unit.
			this.armorPiercing = armorPiercing;
			this.special = special;
			this.towerDescipt = towerDescipt;
		}
		
		// Generic attack function.  Can be used for Melee, Ranged, and Air Towers.
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
				var enemy:Entity = world.nearestToEntity(enemyType, this, true);
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
			
			// Do nothing if there aren't any enemies.
			if(closestEnemy.type != null)
				(Enemy)(closestEnemy).takeDamage(this.damage, this.armorPiercing, this.special);
		}
		
		override public function update():void
		{
			// Deal with displaying tower info when clicked
		}
	}
}