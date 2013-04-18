package enemies 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import Math;
	
	/**
	 * ...
	 * @author Jonathan Benkovic
	 */
	public class Enemy extends Entity 
	{
		public var health:Number;
		public var speed:Number;
		public var armor:Number;	// Percentage of damage blocked
		public var toNest:Boolean;
		public var curPoint:Point;
		public var pointIndex:Number;
		
		public function Enemy(x:Number, y:Number, health:Number, speed:Number, armor:Number) 
		{
			this.x = x;
			this.y = y;
			this.health = health;
			this.speed = speed;
			this.armor = armor;
			this.toNest = true;
			curPoint = Global.genPoint(Global.paths[Global.curLevel][1]);
			pointIndex = 1;
		}
		
		public function takeDamage(damage:Number, armorPiercing:Number, special:String):void
		{
			var modifiedArmor:Number = armor * (1 - armorPiercing);		// Amount of armor left after armor piercing is applied. 
			health = health - (damage * (1 - (modifiedArmor / 100.0)));		
			
			FP.log("Enemy takes damage at " + x + "," + y + " " + health + " health remains");
			
			if (health <= 0)
			{
				dead();
			}
		}
		
		public function nextPoint():void {
			if ((pointIndex + 1) == Global.paths[Global.curLevel].length) {
				// If we've reached the end of the path, grab egg, switch directions and go back
				//getEgg();
				toNest = false;
			}
			else if (pointIndex == 0) {
				//captureEgg();
				dead();
				return;
			}
			if (toNest) {
				curPoint = Global.genPoint(Global.paths[Global.curLevel][++pointIndex]);
				
				// If we're not moving towards the final point in the path (nest), add a bit of randomness
				if (pointIndex != Global.paths[Global.curLevel].length) {
					var radius:Number = Math.random() * (Global.GAME_HEIGHT / 20);
					var theta:Number = Math.random() * 2 * Math.PI;
					
				}
			}
			else {
				curPoint = Global.genPoint(Global.paths[Global.curLevel][--pointIndex]);
				
				// If we're not moving towards the first point in the path (starting point), add a bit of randomness
				if (pointIndex != 0) {
					
				}
			}
		}
		
		override public function update():void
		{
			// This is just for testing, remove for actual path stuff.
			if (distanceToPoint(curPoint.x, curPoint.y) < 5)
				nextPoint();
				
			moveTowards(curPoint.x, curPoint.y, speed*FP.elapsed);
		}
		
		public function dead():void
		{
			world.remove(this);
			
			// Give player gold or hero expierence
		}
		
		
	}

}