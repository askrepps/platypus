package hero
{
	import net.flashpunk.graphics.Image;
	
	public class Mage extends Hero
	{
		public function Mage()
		{
			x = 400;
			y = 300;
			heroImage = new Image(Assets.MAGE);
			graphic = heroImage;
			setHitboxTo(heroImage);
			
			maxHealth = Global.MAGE_HEALTH;
			currentHealth = Global.MAGE_HEALTH;
			attack = Global.MAGE_ATTACK;
			defense = Global.MAGE_DEFENSE;
			speed = Global.MAGE_SPEED;
		}
	}
}