package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class ArmoredEnemy extends Enemy 
	{
		private var enemyImage:Image;
		
		public function ArmoredEnemy(x:Number, y:Number) {
			type = "armored";
			enemyImage = new Image(Assets.ARMORED_ENEMY);
			super(x, y, Global.ARMORED_HEALTH, Global.ARMORED_SPEED, Global.ARMORED_ARMOR, Global.ARMORED_XP);
			
			graphic = enemyImage;
			mask = new Pixelmask(Assets.ARMORED_ENEMY);
		}
		
	}

}