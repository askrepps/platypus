package towers 
{
	import enemies.Enemy;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class Projectile extends Entity 
	{
		private var target:Enemy;
		private var damage:Number;
		private var armorPiercing:Number;
		private var projImage:Image;
		
		public function Projectile(x:Number, y:Number, target:Enemy, damage:Number, armorPiercing:Number, upgradeLevel:Number, image:Class)
		{
			this.x = x;
			this.y = y;
			this.damage = damage;
			this.armorPiercing = armorPiercing;
			this.target = target;
			this.projImage = new Image(image);
			projImage.angle = (180/Math.PI) * findAngle() + 90;
			graphic = projImage;
			mask = new Pixelmask(image);
		}
			
		override public function update():void
		{
			moveTowards(target.centerX, target.centerY, 6);
			
			if(target.health <= 0)
				world.remove(this);
				
			if (collide("normal", x, y) || collide("fast", x, y) || collide("armored", x, y) || collide("flying", x, y))
			{
				target.takeDamage(damage, armorPiercing, "");
				world.remove(this);
			}
		}
		
		private function findAngle():Number
		{
			var horizontal:Number = target.x - x;
			var vertical:Number = target.y - y;
			
			return Math.atan2(horizontal, vertical);
		}
	}
}