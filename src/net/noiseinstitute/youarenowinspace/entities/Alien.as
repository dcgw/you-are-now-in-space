package net.noiseinstitute.youarenowinspace.entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.noiseinstitute.youarenowinspace.YANISEntity;
	
	public class Alien extends YANISEntity {
		
		[Embed(source = 'Alien.png')]
		private const ALIEN_IMAGE:Class;
		
		private var _pos:Number;
		
		public function Alien() {
			graphic = new Image(ALIEN_IMAGE);
			_pos = 0;
			setHitbox(48,48);
		}

		override public function update():void {
			_pos += 0.1;
			x = 160 + 40 * Math.cos(_pos);
			y = 120 + 40 * Math.sin(_pos);
			
			var b:Bullet = collide("bullet", x, y) as Bullet;
			
			if(b) {
				b.destroy();
			}
		}
	}
}