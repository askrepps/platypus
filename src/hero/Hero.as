package hero
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Hero extends Entity
	{
		public var maxHealth:Number;             // max health
		public var currentHealth:Number;         // current health
		public var attack:Number;                // attack power
		public var defense:Number;               // defense
		public var speed:Number;                 // maximum speed
		
		public var xVel:Number;                  // horizontal velocity
		public var yVel:Number;                  // vertical velocity
		
		public var level:Number;                 // current level
		public var xp:Number;                    // current experience points
		
		public var heroImage:Image;              // hero graphic
		
		public function Hero() 
		{
			trace("Hero added!");
			heroImage = new Image(Assets.WARRIOR);
			graphic = heroImage;
			x = 400;
			y = 300;
		}
		
		override public function update():void
		{
			// Check key input
			if (Input.check(Key.W))               // move up
			{
				yVel -= 1;
				if (Math.abs(yVel) > speed)
					yVel = speed * -1;
				
				trace("Wheee!");
			}
			if (Input.check(Key.S))               // move down
			{
				yVel += 1;
				if (Math.abs(yVel) > speed)
					yVel = speed;
			}
			if (Input.check(Key.A))               // move left
			{
				xVel -= 1;
				if (Math.abs(xVel) > speed)
					xVel = speed * -1;
			}
			if (Input.check(Key.D))               // move right
			{
				xVel += 1;
				if (Math.abs(xVel) > speed)
					yVel = speed;
			}
			
			
			// update position
			x += xVel;
			y += yVel;
			
			// temp to keep on screen
			if (x < 0) x = 0;
			if (x > Global.GAME_WIDTH - width) x = Global.GAME_WIDTH - width;
			if (y < 0) y = 0;
			if (y > Global.GAME_HEIGHT - height) y = Global.GAME_HEIGHT - height;
		}
	}
}