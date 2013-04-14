package towers 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.masks.Pixelmask;
	import flash.display.Sprite;
	import flash.display.Graphics;

	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class TowerRangeMask extends Entity 
	{
		protected var sprite:Sprite;
		protected var g:Graphics;
		
		public function TowerRangeMask(tower:Tower) 
		{
<<<<<<< HEAD
=======
			var buttonBmp:BitmapData = new BitmapData(width + 20, height + 20, true, 0);
			
			graphic = new Stamp(buttonBmp, tower.x, tower.y);
			
			
>>>>>>> 0c4eef1e9ff94abee90aa7e343f7e5369faf0701
			sprite = new Sprite;
			g = sprite.graphics;
			g.drawCircle(tower.x - tower.range, tower.y - tower.range, tower.range);
			var bd:BitmapData = new BitmapData(tower.range, tower.range, true, 0);
			bd.draw(sprite);
			
			mask = new Pixelmask(bd);
<<<<<<< HEAD
			
=======
>>>>>>> 0c4eef1e9ff94abee90aa7e343f7e5369faf0701
		}
		
		override public function update():void
		{
			
		}
	}

}