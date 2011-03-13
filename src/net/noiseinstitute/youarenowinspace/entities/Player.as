package net.noiseinstitute.youarenowinspace.entities {
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.youarenowinspace.YANISEntity;
    import net.noiseinstitute.youarenowinspace.behaviours.PlayerDefaultBehaviour;

    public class Player extends YANISEntity {

        private const WIDTH:uint = 21;
        private const HEIGHT:uint = 24;

        private const ASPLODE_WIDTH:uint = 24;
        private const ASPLODE_HEIGHT:uint = 21;

        [Embed(source = 'Player.png')]
        private const PLAYER_SPRITEMAP:Class;

        [Embed(source = 'Alien.png')]
        private const ASPLODE_SPRITEMAP:Class;

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

                var me:Player = this;
                animation.callback = function():void {
                    FP.world.remove(me);
                    if (me.onDie != null) {
                        onDie();
                    }
                }
            }
        }
    }
}