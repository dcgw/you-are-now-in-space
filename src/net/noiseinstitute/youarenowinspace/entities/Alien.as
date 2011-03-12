package net.noiseinstitute.youarenowinspace.entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Alien extends Entity {
		
		[Embed(source = 'Alien.png')]
		private const ALIEN_IMAGE:Class;
		
		private var _pos:Number;
		
		public function Alien() {
			graphic = new Image(ALIEN_IMAGE);
			x = 400;
			y = 200;
			_pos = 0;
		}

		override public function update():void {
			_pos += 0.1;
			x = 400 + 80 * Math.cos(_pos);
			y = 200 + 80 * Math.sin(_pos);
		}
	}
}