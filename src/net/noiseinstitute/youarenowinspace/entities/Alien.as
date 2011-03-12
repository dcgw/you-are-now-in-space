package net.noiseinstitute.youarenowinspace.entities
{
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.youarenowinspace.YANISEntity;

    public class Alien extends YANISEntity {

        private const WIDTH:uint = 24;
        private const HEIGHT:uint = 17;

		[Embed(source = 'Alien.png')]
		private const ALIEN_SPRITEMAP:Class;
		
		private var _pos:Number;
		
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

			_pos = 0;
			setHitbox(WIDTH,HEIGHT);
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