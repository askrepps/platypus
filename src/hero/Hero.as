package hero
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	public class Hero extends Entity
	{
		public var maxHealth:Number;             // max health
		public var currentHealth:Number;         // current health
		public var attack:Number;                // attack power
		public var defense:Number;               // defense
		public var speed:Number;                 // maximum speed
		
		public var level:Number;                 // current level
		public var xp:Number;                    // current experience points
		
		public var heroImage:Image;              // hero graphic
		
		public function Hero() 
		{
			x = 400;
			y = 300;
			heroImage = new Image(Assets.WARRIOR);
			graphic = heroImage;
			setHitboxTo(heroImage);
			speed = Global.WARRIOR_SPEED;
		}
		
		override public function update():void
		{	
			// Check key input
			if (Input.check(Key.W) || Input.check(Key.UP))          // move up
				y -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.S) || Input.check(Key.DOWN))        // move down
				y += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.A) || Input.check(Key.LEFT))        // move left
				x -= speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			if (Input.check(Key.D) || Input.check(Key.RIGHT))       // move right
				x += speed * FP.elapsed * Global.HERO_SPEED_SCALE;
			
			// temp code to keep hero on screen
			if (x < 0) { x = 0; }
			if (x > Global.GAME_WIDTH - width) { x = Global.GAME_WIDTH - width; }
			if (y < 0) { y = 0; }
			if (y > Global.GAME_HEIGHT - height) { y = Global.GAME_HEIGHT - height; }
		}
	}
}