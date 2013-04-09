package towers 
{
	import enemies.Enemy;
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class Projectile extends Entity 
	{
		private var target:Enemy;
		private var damage:Number;
		private var armorPiercing:Number;
		private var special:String;
		
		public function Projectile(x:Number, y:Number, target:Enemy, damage:Number, armorPiercing:Number, special:String) 
		{
			this.x = x;
			this.y = y;
			this.damage = damage;
			this.armorPiercing = armorPiercing;
			this.special = special;
		}
			
		override public function update():void
		{
			moveTowards(target.x, target.y, 4);
			
			if (collide("normal", x, y) || collide("fast", x, y) || collide("armored", x, y) || collide("flying", x, y))
			{
			//	target.takeDamage();
			}
		}
	}
}