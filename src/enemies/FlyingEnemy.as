package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class FlyingEnemy extends Enemy
	{
		private var enemyImage:Image;
		public function FlyingEnemy(x:Number, y:Number, wave:Number)
		{
			type = "flying";
			enemyImage = new Image(Assets.FLYING_ENEMY);
			super(x, y, Global.FLYING_HEALTH, Global.FLYING_SPEED, Global.FLYING_ARMOR, Global.FLYING_XP, wave);
			
			graphic = enemyImage;
			mask = new Pixelmask(Assets.FLYING_ENEMY);
		}
		
	}

}