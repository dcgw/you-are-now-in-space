package net.noiseinstitute.youarenowinspace.entities
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;
	import net.noiseinstitute.youarenowinspace.ControllableEntity;
	import net.noiseinstitute.youarenowinspace.Controller;
	
	public class Player extends ControllableEntity {

        private const WIDTH:uint = 21;
        private const HEIGHT:uint = 24;

		[Embed(source = 'Player.png')]
		private const PLAYER_SPRITEMAP:Class;

		private const SHOOT_INTERVAL:uint = 6;
		
		[Embed(source = '../data/laser.mp3')]
		private const LASER_SOUND:Class;
		
		public function Player() {
            width = WIDTH;
            height = HEIGHT;
            x = 160 - width/2;

            var animation:Spritemap = new Spritemap(PLAYER_SPRITEMAP, WIDTH, HEIGHT);
            graphic = animation;
            animation.add("spinning", [0,1,2,3,4,5,6], 0.25)
            animation.play("spinning");
		}
		
		override public function execute(cmd:int):void {
			super.execute(cmd);
			if(cmd == Controller.SHOOT && hasElapsed(SHOOT_INTERVAL)) {
				FP.world.add(new Bullet(centerX, centerY));
				new Sfx(LASER_SOUND).play();
				resetTime();
			}
		}
	}
}