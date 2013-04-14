package towers 
{
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class MeleeTower extends Tower 
	{
		private var timer:Number;
		
		public function MeleeTower(x:Number, y:Number) 
		{
			super(x, y, Global.MELEE_RANGE, Global.MELEE_DAMAGE, Global.MELEE_SPEED, Global.MELEE_CANATTACK, Global.MELEE_ARMORPIERCING, "", Global.MELEE_TOWERDESCIPT);
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
					range = Global.MELEE_RANGE_UPGRADE1;
					damage = Global.MELEE_DAMAGE_UPGRADE1;
					speed = Global.MELEE_SPEED_UPGRADE1;
					break;
				case 2:
					range = Global.MELEE_RANGE_UPGRADE2;
					damage = Global.MELEE_DAMAGE_UPGRADE2;
					speed = Global.MELEE_SPEED_UPGRADE2;
					special = Global.MELEE_SPECIAL;
			}
		}
		
		override public function update():void
		{
			timer += FP.elapsed;
			
			

			if (timer >= speed)
			{
				timer = 0;
				attack();
			}
		}
	}
}