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
	public class NormalEnemy extends Enemy
	{
		public function NormalEnemy(x:Number, y:Number, wave:Number) 
		{
			type = "normal";
			enemyImage = new Spritemap(Assets.NORMAL_ENEMY, 50, 25);
			enemyImage.add("walking", [0, 1, 2, 3], 5, true);
			enemyImage.play("walking");
			
			super(x, y, Global.NORMAL_HEALTH, Global.NORMAL_SPEED, Global.NORMAL_ARMOR, Global.NORMAL_XP, wave);
			
			graphic = enemyImage;
			setHitbox(50, 25);
		}
	}
}