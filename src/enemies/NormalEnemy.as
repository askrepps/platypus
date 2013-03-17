package enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
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
			super(x, y, 50, 2, 0);
			
			graphic = enemyImage;
		}
		
	}

}