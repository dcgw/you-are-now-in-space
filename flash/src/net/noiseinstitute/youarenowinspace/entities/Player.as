package net.noiseinstitute.youarenowinspace.entities {
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.youarenowinspace.YANISEntity;
    import net.noiseinstitute.youarenowinspace.behaviours.PlayerDefaultBehaviour;

    public class Player extends YANISEntity {

        private static const WIDTH:uint = 21;
        private static const HEIGHT:uint = 24;

        private static const ASPLODE_WIDTH:uint = 24;
        private static const ASPLODE_HEIGHT:uint = 21;

        [Embed(source = 'Player.png')]
        private static const PLAYER_SPRITEMAP:Class;

        [Embed(source = 'Alien.png')]
        private static const ASPLODE_SPRITEMAP:Class;

        [Embed(source="PlayerSplode.mp3")]
        private static const ASPLODE_SOUND:Class;

        private var dead:Boolean = false;

        public var onDie:Function;

        public function Player () {
            width = WIDTH;
            height = HEIGHT;
            behaviour = new PlayerDefaultBehaviour(this);

            var animation:Spritemap = new Spritemap(PLAYER_SPRITEMAP, WIDTH, HEIGHT);
            graphic = animation;
            animation.add("spinning", [0,1,2,3,4,5,6], 0.25);
            animation.play("spinning");

            setHitbox(WIDTH, HEIGHT);
        }

        override public function update ():void {
            super.update();

            if (!dead && collide("deadly", x, y)) {
                dead = true;
                behaviour = null;

                var animation:Spritemap = new Spritemap(ASPLODE_SPRITEMAP, ASPLODE_WIDTH, ASPLODE_HEIGHT);
                animation.add("asploding", [28,29,30,31,32,33,34], 0.25);
                animation.play("asploding");
                graphic = animation;

                new Sfx(ASPLODE_SOUND).play();

                var me:Player = this;
                animation.callback = function():void {
                    FP.world.remove(me);
                    if (me.onDie != null) {
                        onDie();
                    }
                }
            }

            if (x < 0) {
                x = 0;
            }

            if (x+width > FP.screen.width) {
                x = FP.screen.width - width;
            }

            if (y < 0) {
                y = 0;
            }

            if (y+height > FP.screen.height) {
                y = FP.screen.height - height;
            }
        }
    }
}