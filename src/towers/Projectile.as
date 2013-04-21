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
		
		public function Projectile(x:Number, y:Number, target:Enemy, damage:Number, armorPiercing:Number, upgradeLevel:Number) 
		{
			this.x = x;
			this.y = y;
			this.damage = damage;
			this.armorPiercing = armorPiercing;
			this.target = target;
			
			if(upgradeLevel == 0)
			{
				projImage = new Image(Assets.SPEAR_PROJ);
				mask = new Pixelmask(Assets.SPEAR_PROJ);
			}
			else if (upgradeLevel == 1)
			{
				projImage = new Image(Assets.ARROW_PROJ);
				mask = new Pixelmask(Assets.ARROW_PROJ);
			}
			else
			{
				projImage = new Image(Assets.BULLET_PROJ);
				mask = new Pixelmask(Assets.BULLET_PROJ);
			}
			graphic = projImage;
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
	}
}