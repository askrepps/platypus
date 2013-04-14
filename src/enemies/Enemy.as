package enemies 
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class Enemy extends Entity 
	{
		public var health:Number;
		public var speed:Number;
		public var armor:Number;	// Percentage of damage blocked
		
		public function Enemy(x:Number, y:Number, health:Number, speed:Number, armor:Number) 
		{
			this.x = x;
			this.y = y;
			this.health = health;
			this.speed = speed;
			this.armor = armor;
		}
		
		public function takeDamage(damage:Number, armorPiercing:Number, special:String):void
		{
			var modifiedArmor:Number = armor * (1 - armorPiercing);		// Amount of armor left after armor piercing is applied. 
			health = health - (damage * (1 - (modifiedArmor / 100.0)));		
			
			trace("Enemy takes damage at " + x + "," + y + " " + health + " health remains");
			
			if (health <= 0)
			{
				dead();
			}
		}
		
		public function dead():void
		{
			world.remove(this);
			
			// Give player gold or hero expierence
		}
		
		
	}

}