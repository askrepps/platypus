package towers 
{
	import enemies.Enemy;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	import towers.TowerUI;
	
	import ui.BuildButton;
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class AoETower extends Tower 
	{
		private var towerImage:Image;
		private var timer:Number;
		private static var towerUI:TowerUI;
		private var explosion:Explosion;
		
		public function AoETower(x:Number, y:Number) 
		{
			super(x, y, Global.AOE_RANGE, Global.AOE_DAMAGE, Global.AOE_SPEED, Global.AOE_CANATTACK, Global.AOE_ARMORPIERCING, "", Global.AOE_TOWERDESCIPT, this, Global.AOE_COST, Global.AOE_UPGRADE_COST);
			towerImage = new Image(Assets.AOE_TOWER_1);
			super.graphic = towerImage;
			timer = 0;
			setHitboxTo(towerImage);
			towerUI = new TowerUI(centerX, centerY, this);
		}
		
		override public function upgrade():void
		{
			if (upgradeCur < 2)
				upgradeCur++;
			
			switch (upgradeCur)
			{
				case 1:
					range = Global.AOE_RANGE_UPGRADE1;
					damage = Global.AOE_DAMAGE_UPGRADE1;
					speed = Global.AOE_SPEED_UPGRADE1;
					towerImage = new Image(Assets.AOE_TOWER_2);
					graphic = towerImage;
					break;
				case 2:
					range = Global.AOE_RANGE_UPGRADE2;
					damage = Global.AOE_DAMAGE_UPGRADE2;
					speed = Global.AOE_SPEED_UPGRADE2;
					special = Global.AOE_SPECIAL;
					towerImage = new Image(Assets.AOE_TOWER_3);
					graphic = towerImage;
			}
		}
		
		override public function attack():void
		{
			var allEnemies:Array = new Array();
			// Finds the closest enemy of any type the tower can attack.
			for each(var enemyType:String in canAttack)
			{
				world.getType(enemyType, allEnemies)
			
				for each(var enemy:Enemy in allEnemies)
				{
					var distToEnemy:Number = Math.sqrt((this.centerX - enemy.centerX) * (this.centerX - enemy.centerX) + ((this.centerY - enemy.centerY) * (this.centerY - enemy.centerY)));
						
					// Ignore the enemy if it is out of range.
					if(distToEnemy <= this.range)
					{
						if (upgradeCur == 2)
						{
							(Enemy)(enemy).getPoisoned(Global.POISON_DURATION, Global.POISON_DAMAGE);
							explosion = new Explosion(this, Assets.GREEN_EXPLOSION);
							world.add(explosion);
						}
						else
						{
							(Enemy)(enemy).takeDamage(this.damage, this.armorPiercing, this.special);
							explosion = new Explosion(this, Assets.EXPLOSION);
							world.add(explosion);
						}
					}
				}
			}
		}
	}
}
