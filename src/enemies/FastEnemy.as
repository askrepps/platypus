package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class FastEnemy extends Enemy 
	{
		public function FastEnemy(x:Number, y:Number) 
		{
			type = "fast";
			enemyImage = new Spritemap(Assets.FAST_ENEMY, 50, 29);
			enemyImage.add("walking", [0, 1, 2, 3], 5, true);
			enemyImage.play("walking");
			
			super(x, y, Global.FAST_HEALTH, Global.FAST_SPEED, Global.FAST_ARMOR, Global.FAST_XP);
			
			graphic = enemyImage;
			setHitbox(50, 29);
		}
	}
}