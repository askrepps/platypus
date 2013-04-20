package enemies 
{
	import flash.geom.Point;
	
	import hero.Hero;
	
	import levels.Egg;
	import levels.Nest;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	import ui.HealthBar;
	

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
		public var isPoisoned:Boolean;
		public var poisonDuration:Number;
		public var poisonTimer:Number;
		public var poisonDamage:Number;
		public var poisonCounter:Number;
		
		private var healthBar:HealthBar; 	// Enemies health bar.
		private var maxHealth:Number;	
		
		public var egg:Egg;
		
		public function Enemy(x:Number, y:Number, health:Number, speed:Number, armor:Number) 
		{
			this.x = x;
			this.y = y;
			this.health = health;
			this.speed = speed;
			this.armor = armor;
			this.toNest = true;
			curPoint = Global.genPoint(Global.paths[Global.curLevel][0]);
			//nextPoint // Generate first point to move to with some randomness
			pointIndex = 1;
			isPoisoned = false;
			
			maxHealth = health;
			healthBar = new HealthBar(centerX, (this.y + 10), 20, 5, health);
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
		
		// Set poison DoT variables
		public function getPoisoned(duration:Number, damage:Number):void {
			poisonDuration = duration;
			poisonDamage = damage;
			isPoisoned = true;
			
		}
		
		// Check if enemy should be damaged by poison
		public function takePoisonDamage():void {
			if (poisonDuration > 0) {
				poisonDuration -= FP.elapsed;
				poisonCounter += FP.elapsed;
				
				if (poisonCounter > .5)
				{
					health -= poisonDamage;
					poisonCounter -= .5
				}
			}
			else {
				poisonDuration = 0;
				poisonCounter = 0;
				isPoisoned = false;
			}
		}
		public function nextPoint():void {
			var radius:Number;
			var theta:Number;
			var x:Number;
			var y:Number;
				
			if ((pointIndex + 1) == Global.paths[Global.curLevel].length) {
				// If we've reached the end of the path, grab egg, switch directions and go back
				//getEgg();
				toNest = false;
			}
			else if (pointIndex == 0 && !toNest) {
				//captureEgg();
				dead();
				return;
			}
			if (toNest) {
				curPoint = Global.genPoint(Global.paths[Global.curLevel][++pointIndex]);
				
				// If we're not moving towards the final point in the path (nest), add a bit of randomness
				if (pointIndex != Global.paths[Global.curLevel].length) {
					radius = Math.random() * (Global.GAME_HEIGHT / 5);
					theta = Math.random() * 2 * Math.PI;
					x = Math.sqrt(radius) * Math.cos(theta);
					y = Math.sqrt(radius) * Math.sin(theta);
					
					curPoint.x += x;
					curPoint.y += y;
					
				}
			}
			else {
				curPoint = Global.genPoint(Global.paths[Global.curLevel][--pointIndex]);
				
				// If we're not moving towards the first point in the path (starting point), add a bit of randomness
				if (pointIndex != 0) {
					radius = Math.random() * (Global.GAME_HEIGHT / 5);
					theta = Math.random() * 2 * Math.PI;
					x = Math.sqrt(radius) * Math.cos(theta);
					y = Math.sqrt(radius) * Math.sin(theta);
					
					curPoint.x += x;
					curPoint.y += y;
				}
			}
		}
		
		override public function removed():void
		{
			world.remove(healthBar);
		}
		
		override public function update():void
		{
			var collidedNest:Entity;
			
			if (healthBar.name == null)
			{
				healthBar.name = "done";
				world.add(healthBar);
			}
			else
			{
				healthBar.updateVal(centerX, this.y, health/maxHealth);
			}
			
			if (maxHealth == health)
			{
				healthBar.visible = false;
			}
			else
			{
				healthBar.visible = true;
			}
			
			
			if (egg == null)
			{
				collidedNest = collideTypes("nest", x, y);
				if (collidedNest != null)
				{
					egg = (collidedNest as Nest).stealEgg();
					world.add(egg);
				}
			}
			else
			{
				egg.updatePos(x - width, y);
			}
			
			
			if (isPoisoned)
				takePoisonDamage();
				
			// This is just for testing, remove for actual path stuff.
			if (distanceToPoint(curPoint.x, curPoint.y) < 5)
				nextPoint();
				
			moveTowards(curPoint.x, curPoint.y, speed*FP.elapsed);
		}
		
		public function dead():void
		{
			world.remove(this);
			Global.hero.gainXP(5);
			Global.playerGold += 25;
			
			if (egg != null)
				egg.isCarried = false;
		}
		
		
	}

}