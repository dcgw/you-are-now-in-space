package net.noiseinstitute.youarenowinspace.entities {
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.youarenowinspace.YANISEntity;
    import net.noiseinstitute.youarenowinspace.behaviours.PlayerDefaultBehaviour;

    public class Player extends YANISEntity {

        private const WIDTH:uint = 21;
        private const HEIGHT:uint = 24;

        [Embed(source = 'Player.png')]
        private const PLAYER_SPRITEMAP:Class;

        public function Player () {
            width = WIDTH;
            height = HEIGHT;
            behaviour = new PlayerDefaultBehaviour(this);

            var animation:Spritemap = new Spritemap(PLAYER_SPRITEMAP, WIDTH, HEIGHT);
            graphic = animation;
            animation.add("spinning", [0,1,2,3,4,5,6], 0.25);
            animation.play("spinning");
        }
    }
}