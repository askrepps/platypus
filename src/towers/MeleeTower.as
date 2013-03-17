package towers 
{
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class MeleeTower extends Tower 
	{
		private var timer:Number;
		
		public function MeleeTower(x:Number, y:Number) 
		{
			super(x, y, Global.MELEE_RANGE, Global.MELEE_DAMAGE, Global.MELEE_SPEED, Global.MELEE_CANATTACK, Global.MELEE_ARMORPIERCING, Global.MELEE_SPECIAL, Global.MELEE_TOWERDESCIPT);
			// graphic = ;
			timer = 0;
		}
		
		public function upgrade():void
		{
			if (upgradeCur < 2)
				upgradeCur++;
			
			switch (upgradeCur)
			{
				case 1:
					range += ;
					damage += ;
					speed += ;
					armorPiercing += ;
					break;
				case 2:
					range += ;
					damage += ;
					speed += ;
					armorPiercing += ;
					special = "Ignore Armor";
					towerDescipt = "A highly powerful melee tower. Due to the totally-non-copyright-infringing lightsword it ignores unit armor!"
			}
		}
		
		override public function update():void
		{
			timer++;
			
			if (timer >= speed)
			{
				timer = 0;
				attack();
			}
		}
	}
}