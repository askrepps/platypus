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
		private var towerUI:TowerUI;
	
		
		public function Tower(x:Number, y:Number, range:Number, damage:Number, speed:Number, canAttack:Array, armorPiercing:Number, special:String, towerDescript:String, towerUI:TowerUI)
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
		}
		
		public function attack():void
		{
			
		}
		
		override public function removed():void
		{
			FP.world.remove(towerUI);
		}
		
		override public function update():void
		{
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