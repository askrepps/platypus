package hero
{
	public class Warrior extends Hero
	{
		import net.flashpunk.graphics.Image;
		
		public function Warrior(startX:Number, startY:Number)
		{
			super(startX, startY);
			
			heroImage = new Image(Assets.WARRIOR);
			graphic = heroImage;
			setHitboxTo(heroImage);
			
			maxHealth = Global.WARRIOR_HEALTH;
			currentHealth = Global.WARRIOR_HEALTH;
			attack = Global.WARRIOR_ATTACK;
			defense = Global.WARRIOR_DEFENSE;
			speed = Global.WARRIOR_SPEED;
		}
		
		public override function ability1():void
		{
			super.ability1();
			ability1CD = Global.WARRIOR_ABIL_1_CD;
		}
		
		public override function ability2():void
		{
			super.ability2();
			ability2CD = Global.WARRIOR_ABIL_2_CD;
		}
		
		public override function ability3():void
		{
			super.ability3();
			ability3CD = Global.WARRIOR_ABIL_3_CD;
		}
		
		public override function basicAttack():void
		{
			super.basicAttack();
			basicCD = Global.WARRIOR_BASIC_CD;
		}
	}
}