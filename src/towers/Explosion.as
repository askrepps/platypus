package towers
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;

	public class Explosion extends Entity
	{
		private var explosionImage:Spritemap;
		
		public function Explosion(tower:AoETower, image:Class)
		{
			
			layer = -10;
			explosionImage = new Spritemap(image, 200, 134.5, removeMe);
			explosionImage.add("explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 15, false);
			graphic = explosionImage;
			setHitbox(200, 134.5);
			x = tower.centerX - width/2;
			y = tower.centerY - height/2;
			explosionImage.play("explode");
		}
		
		public function removeMe():void
		{
			world.remove(this);
		}
	}
}