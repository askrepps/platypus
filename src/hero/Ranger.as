package hero
{
	public class Ranger extends Hero
	{
		import net.flashpunk.graphics.Image;
		
		public function Ranger(startX:Number, startY:Number)
		{
			super(startX, startY);
			
			heroImage = new Image(Assets.RANGER);
			graphic = heroImage;
			setHitboxTo(heroImage);
			
			maxHealth = Global.RANGER_HEALTH;
			currentHealth = Global.RANGER_HEALTH;
			attack = Global.RANGER_ATTACK;
			defense = Global.RANGER_DEFENSE;
			speed = Global.RANGER_SPEED;
		}
		
		public override function ability1():void
		{
			super.ability1();
			ability1CD = Global.RANGER_ABIL_1_CD;
		}
		
		public override function ability2():void
		{
			super.ability2();
			ability2CD = Global.RANGER_ABIL_2_CD;	
		}
		
		public override function ability3():void
		{
			super.ability3();
			ability3CD = Global.RANGER_ABIL_3_CD;
		}
	}
}