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
			super(x, y, 50, 2, 0);
			
			graphic = enemyImage;
			mask = new Pixelmask(Assets.NORMAL_ENEMY);
		}
		
		override public function update():void
		{
			// This is just for testing, remove for actual path stuff.
			x++;
		}
	}

}