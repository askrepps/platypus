package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class NormalEnemy extends Enemy
	{
		private var enemyImage:Image;
		
		public function NormalEnemy(x:Number, y:Number) 
		{
			type = "normal";
			enemyImage = new Image(Assets.NORMAL_ENEMY);
			super(x, y, Global.NORMAL_HEALTH, 100, 0);
			
			graphic = enemyImage;
			mask = new Pixelmask(Assets.NORMAL_ENEMY);
		}
	}

}