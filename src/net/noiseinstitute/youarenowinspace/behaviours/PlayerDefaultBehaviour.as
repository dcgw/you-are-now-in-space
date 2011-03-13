package net.noiseinstitute.youarenowinspace.behaviours {
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.utils.Input;
    import net.noiseinstitute.youarenowinspace.entities.Bullet;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class PlayerDefaultBehaviour implements IBehaviour {

        [Embed(source = '../data/laser.mp3')]
        private static const LASER_SOUND:Class;

        public var fixedX:Boolean = false;

        private const SHOOT_INTERVAL:uint = 24;
        private const SPEED:uint = 5;

        private var player:Player;
        private var timer:ResettableTimer = new ResettableTimer();

        public function PlayerDefaultBehaviour(player:Player) {
            this.player = player;
        }

        public function update ():void {
            timer.update();

            if (Input.pressed("fire") && timer.hasElapsed(SHOOT_INTERVAL)) {
                FP.world.add(new Bullet(player.centerX, player.centerY));
                new Sfx(LASER_SOUND).play();
                timer.resetTime();
            }

            if (Input.check("left") && !fixedX) {
                player.x -= SPEED;
            }

            if (Input.check("right") && !fixedX) {
                player.x += SPEED;
            }

            if (Input.check("up")) {
                player.y -= SPEED;
            }

            if (Input.check("down")) {
                player.y += SPEED;
            }
        }
    }
}