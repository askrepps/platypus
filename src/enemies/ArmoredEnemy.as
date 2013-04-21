package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class ArmoredEnemy extends Enemy 
	{
		public function ArmoredEnemy(x:Number, y:Number) 
		{
			type = "armored";
			enemyImage = new Spritemap(Assets.ARMORED_ENEMY, 50, 50);
			enemyImage.add("walking", [0, 1, 2, 3], 5, true);
			super(x, y, Global.ARMORED_HEALTH, Global.ARMORED_SPEED, Global.ARMORED_ARMOR, Global.ARMORED_XP);
			
			graphic = enemyImage;
			enemyImage.play("walking");
			setHitbox(50, 50);
		}
	}
}