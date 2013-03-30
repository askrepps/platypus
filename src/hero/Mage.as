package hero
{
	import net.flashpunk.graphics.Image;
	
	public class Mage extends Hero
	{
		public function Mage(startX:Number, startY:Number)
		{
			super(startX, startY);

			heroImage = new Image(Assets.MAGE);
			graphic = heroImage;
			setHitboxTo(heroImage);
			
			maxHealth = Global.MAGE_HEALTH;
			currentHealth = Global.MAGE_HEALTH;
			attack = Global.MAGE_ATTACK;
			defense = Global.MAGE_DEFENSE;
			speed = Global.MAGE_SPEED;
		}
		
		public override function ability1():void
		{
			super.ability1();
			ability1CD = Global.MAGE_ABIL_1_CD;
		}
		
		public override function ability2():void
		{
			super.ability2();
			ability2CD = Global.MAGE_ABIL_2_CD;
		}
		
		public override function ability3():void
		{
			super.ability3();
			ability3CD = Global.MAGE_ABIL_3_CD;
		}
	}
}