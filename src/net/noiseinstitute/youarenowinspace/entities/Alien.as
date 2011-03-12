package net.noiseinstitute.youarenowinspace.entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.noiseinstitute.youarenowinspace.YANISEntity;
	
	public class Alien extends YANISEntity {
		
		[Embed(source = 'Alien.png')]
		private const ALIEN_IMAGE:Class;
		
		private var _pos:Number;
		private var pathX:Number;
		private var pathY:Number;
		private var pathW:Number;
		private var pathH:Number;
		
		public function Alien() {
			graphic = new Image(ALIEN_IMAGE);
			_pos = Math.random() * (Math.PI * 2);
			setHitbox(48,48);
			
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