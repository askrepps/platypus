package hero
{
	public class Warrior extends Hero
	{
		import net.flashpunk.graphics.Image;
		
		public function Warrior()
		{
			x = 400;
			y = 300;
			heroImage = new Image(Assets.WARRIOR);
			graphic = heroImage;
			setHitboxTo(heroImage);
			
			maxHealth = Global.WARRIOR_HEALTH;
			currentHealth = Global.WARRIOR_HEALTH;
			attack = Global.WARRIOR_ATTACK;
			defense = Global.WARRIOR_DEFENSE;
			speed = Global.WARRIOR_SPEED;
		}
	}
}