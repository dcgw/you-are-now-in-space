package net.noiseinstitute.youarenowinspace.entities
{

	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.noiseinstitute.youarenowinspace.YANISEntity;
	
	public class Alien extends YANISEntity {
		
        private const WIDTH:uint = 24;
        private const HEIGHT:uint = 17;

		[Embed(source = 'Alien.png')]
		private const ALIEN_SPRITEMAP:Class;
		
		private var _pos:Number;
		private var pathX:Number;
		private var pathY:Number;
		private var pathW:Number;
		private var pathH:Number;
		
		public function Alien() {
            width = WIDTH;
            height = HEIGHT;

            var animation:Spritemap = new Spritemap(ALIEN_SPRITEMAP, WIDTH, HEIGHT);
            graphic = animation;
            animation.add("red", [0,1,2,3,4,5], 0.25);
            animation.add("green", [6,7,8,9,10,11], 0.25);
            animation.add("brown", [12,13,14,15,16,17], 0.25);
            animation.add("grey", [18,19,20,21,22,23], 0.25);
            animation.play("red");

			setHitbox(WIDTH,HEIGHT);

			_pos = Math.random() * (Math.PI * 2);
			
			pathX = Math.random() * FP.screen.width;
			pathY = Math.random() * FP.screen.height;
			pathW = Math.random() * FP.screen.width / 2;
			pathH = Math.random() * FP.screen.height / 2;
		}

		override public function update():void {
			_pos += 0.1;
			x = pathX + pathW * Math.cos(_pos);
			y = pathY + pathH * Math.sin(_pos);
			
			// Have we been shot?
			var b:Bullet = collide("bullet", x, y) as Bullet;
			if(b) {
				// Destroy the bullet
				b.destroy();
				
				FP.world.remove(this);
			}
		}
	}
}