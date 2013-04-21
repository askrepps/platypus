package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class FastEnemy extends Enemy 
	{
		private var enemyImage:Image;
		public function FastEnemy(x:Number, y:Number, wave:Number) {
			type = "fast";
			enemyImage = new Image(Assets.FAST_ENEMY);
			super(x, y, Global.FAST_HEALTH, Global.FAST_SPEED, Global.FAST_ARMOR, Global.FAST_XP, wave);
			
			graphic = enemyImage;
			mask = new Pixelmask(Assets.FAST_ENEMY);
		}
		
	}

}