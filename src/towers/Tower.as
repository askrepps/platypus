package towers 
{
	import enemies.Enemy;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import towers.TowerUI;
	/*
	 * "Abstract" class that is the base for all tower types.
	 * @author Jonathan Benkovic
	 */
	public class Tower extends Entity 
	{
		public var range:Number;			// Pixel range the tower can hit.
		public var damage:Number;			// Damage the tower does per hit.
		public var speed:Number;			// Num of attacks per second.
		public var canAttack:Array; 		// Array of strings that holds the type of enemies the tower can hit.
		public var upgradeCur:Number;		// Current upgrade level.
		public var armorPiercing:Number;  	// Percentage of armor ignored by attacks.
		public var special:String;			// Special effect from attack (e.g. slow, stun, etc.)
		public var towerDescipt:String;
		public var cost:Number;
		public var upgradeCost:Number;
		private var towerUI:TowerUI;
		private var timer:Number;
		
		public function Tower(x:Number, y:Number, range:Number, damage:Number, speed:Number, canAttack:Array, armorPiercing:Number, special:String, towerDescript:String, towerUI:TowerUI, cost:Number, upgradeCost:Number)
		{
			this.x = x;
			this.y = y;
			this.range = range;
			this.damage = damage;
			this.speed = speed;
			this.canAttack = canAttack;
			this.upgradeCur = 0;			// All towers start at base unit.
			this.armorPiercing = armorPiercing;
			this.special = special;
			this.towerDescipt = towerDescipt;
			this.towerUI = towerUI;
			this.cost = cost;
			this.upgradeCost = upgradeCost;
			timer = 0;
		}
		
		// Override this function
		public function attack():void
		{
			
		}
		
		// Override this function
		public function upgrade():void
		{
			
		}
		
		override public function removed():void
		{
			FP.world.remove(towerUI);
		}
		
		override public function update():void
		{
			timer += FP.elapsed;
			
			if (timer >= speed)
			{
				timer = 0;
				attack();
			}
			// Deal with displaying tower info when clicked
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{
				//world.add(new HoverText(x,y));
				if(Input.mousePressed)
					world.add(towerUI);
			}
			
		}
	}
}