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
	public class FlyingEnemy extends Enemy
	{
		public function FlyingEnemy(x:Number, y:Number, wave:Number)
		{
			type = "flying";
			enemyImage = new Spritemap(Assets.FLYING_ENEMY, 32, 50);
			enemyImage.add("flying", [0, 1, 2, 3], 5, true);
			enemyImage.play("flying");
			
			super(x, y, Global.FLYING_HEALTH, Global.FLYING_SPEED, Global.FLYING_ARMOR, Global.FLYING_XP, wave);
			
			graphic = enemyImage;
			setHitbox(32, 50);
		}
	}
}