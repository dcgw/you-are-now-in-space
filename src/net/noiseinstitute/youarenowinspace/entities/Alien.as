package net.noiseinstitute.youarenowinspace.entities
{
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.youarenowinspace.YANISEntity;

    public class Alien extends YANISEntity {
		
        private const WIDTH:uint = 24;
        private const HEIGHT:uint = 17;

		[Embed(source = 'Alien.png')]
		private const ALIEN_SPRITEMAP:Class;

        public static const RED:String = "red";
        public static const GREEN:String = "green";
        public static const BROWN:String = "brown";
        public static const GREY:String = "grey";

        public function Alien (colour:String = RED) {
            width = WIDTH;
            height = HEIGHT;

            var animation:Spritemap = new Spritemap(ALIEN_SPRITEMAP, WIDTH, HEIGHT);
            graphic = animation;
            animation.add(RED, [0,1,2,3,4,5], 0.25);
            animation.add(GREEN, [6,7,8,9,10,11], 0.25);
            animation.add(BROWN, [12,13,14,15,16,17], 0.25);
            animation.add(GREY, [18,19,20,21,22,23], 0.25);
			
            animation.play(colour);

			setHitbox(WIDTH,HEIGHT);
		}

		override public function update():void {
            super.update();

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