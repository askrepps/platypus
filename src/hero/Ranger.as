package hero
{
	public class Ranger extends Hero
	{
		import net.flashpunk.graphics.Image;
		
		public function Ranger()
		{
			x = 400;
			y = 300;
			heroImage = new Image(Assets.RANGER);
			graphic = heroImage;
			setHitboxTo(heroImage);
			
			maxHealth = Global.RANGER_HEALTH;
			currentHealth = Global.RANGER_HEALTH;
			attack = Global.RANGER_ATTACK;
			defense = Global.RANGER_DEFENSE;
			speed = Global.RANGER_SPEED;
		}
	}
}