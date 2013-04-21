package enemies 
{
	import flash.geom.Point;
	
	import hero.Hero;
	
	import levels.Egg;
	import levels.Nest;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
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
		public var isSlowed:Boolean;
		public var slowDuration:Number;
		public var slowAmount:Number;
		public var isStunned:Boolean;
		public var stunDuration:Number;
		public var elapsed:Number;
		public var attackedByHero:Boolean;
		public var xp:Number;
		public var enemyImage:Spritemap;

		public var wave:Number;				// Wave number the enemy is in.
		private var healthBar:HealthBar; 	// Enemies health bar.
		private var maxHealth:Number;	
		
		public var egg:Egg;
		
		public function Enemy(x:Number, y:Number, health:Number, speed:Number, armor:Number, xp:Number, wave:Number) 
		{
			this.x = x;
			this.y = y;
			this.health = health;
			this.speed = speed;
			this.armor = armor;
			this.toNest = true;
			this.xp = xp;
			this.wave = wave;
			curPoint = Global.genPoint(Global.paths[0][0]);
			pointIndex = 1;
			isPoisoned = false;
			elapsed = 0;
			
			attackedByHero = false;
			
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
		public function getPoisoned(duration:Number, damage:Number):void 
		{
			poisonDuration = duration;
			poisonDamage = damage;
			isPoisoned = true;
		}
		
		// Check if enemy should be damaged by poison
		public function takePoisonDamage():void 
		{
			if (poisonDuration > 0) 
			{
				poisonDuration -= FP.elapsed;
				poisonCounter += FP.elapsed;
				
				if (poisonCounter > .5)
				{
					health -= poisonDamage;
					poisonCounter -= .5
				}
			}
			else 
			{
				poisonDuration = 0;
				poisonCounter = 0;
				isPoisoned = false;
			}
		}
		
		public function slow(duration:Number, amount:Number):void 
		{
			isSlowed = true;
			slowDuration = duration;
			slowAmount = amount;
		}
		
		public function stun(duration:Number):void 
		{
			isStunned = true;
			stunDuration = duration;
		}
		public function nextPoint():void 
		{
			var radius:Number;
			var theta:Number;
			var x:Number;
			var y:Number;
				
			if ((pointIndex + 1) == Global.paths[0].length) 
			{
				// If we've reached the end of the path, grab egg, switch directions and go back
				//getEgg();
				toNest = false;
				enemyImage.flipped = true;
			}
			else if (pointIndex == 0 && !toNest) 
			{
				//captureEgg();
				if(egg != null)
					Global.eggsLeft--;
				world.remove(this);
				return;
			}
			if (toNest) 
			{
				// Get actual point on path from which we draw a random point close by
				curPoint = Global.genPoint(Global.paths[0][++pointIndex]);
				
				// If we're not moving towards the final point in the path (nest), add a bit of randomness
				if (pointIndex != Global.paths[0].length) 
				{
					radius = Math.random() * (Global.GAME_HEIGHT);
					theta = Math.random() * 2 * Math.PI;
					x = Math.sqrt(radius) * Math.cos(theta);
					y = Math.sqrt(radius) * Math.sin(theta);
					
					curPoint.x += x;
					curPoint.y += y;
					
				}
			}

			else 
			{
				curPoint = Global.genPoint(Global.paths[0][--pointIndex]);
				
				// If we're not moving towards the first point in the path (starting point), add a bit of randomness
				if (pointIndex != 0) 
				{
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
			var collidedEgg:Entity;
			
			// Draw health bar
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
			
			// Handle the stealing of an egg, "carry" the egg along with the enemy
			if (egg == null)
			{
				collidedNest = collideTypes("nest", x, y);
				
				if (collidedNest != null)
				{
					egg = (collidedNest as Nest).stealEgg();
					
					// Make sure that there is another egg left in the nest before trying to add it
					if (egg != null)
						world.add(egg);
				}
				
				collidedEgg = collideTypes("egg", x, y);
				if (collidedEgg != null && egg == null && !(collidedEgg as Egg).isCarried) 
				{
					(collidedEgg as Egg).isCarried = true;
					egg = (collidedEgg as Egg);
				}
			}
			else
			{
				toNest = false;
				enemyImage.flipped = true;
				egg.updatePos(x + width/2, y);
			}
			
			// Handle damage from poison
			if (isPoisoned)
				takePoisonDamage();
				
			// Iterate through points on the path
			if (distanceToPoint(curPoint.x, curPoint.y) < 2)
				nextPoint();
			
			// Check for impairments
			if (!isStunned) 
			{
				if (isSlowed) 
				{
					slowDuration -= FP.elapsed;
					if (slowDuration <= 0) isSlowed = false;
					// Decrease speed based on the slow amount
					moveTowards(curPoint.x, curPoint.y, (1 - slowAmount) * speed * FP.elapsed);
				}
				else 
				{
					moveTowards(curPoint.x, curPoint.y, speed * FP.elapsed);
				}
			}
			else 
			{
				// Don't move if we are stunned
				stunDuration -= FP.elapsed;
				if (stunDuration <= 0) isStunned = false;
			}
		}
		
		public function dead():void
		{
			// Award hero gold and xp
			if (attackedByHero)
				Global.hero.gainXP(xp);
			
			Global.playerGold += 25;
			
			// Drop egg
			if (egg != null)
				egg.isCarried = false;
				
			world.remove(this);
		}
		
		
	}

}