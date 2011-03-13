package net.noiseinstitute.youarenowinspace.worlds {
    import avmplus.finish;

    import flash.media.Sound;
    import flash.media.SoundChannel;

    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.noiseinstitute.youarenowinspace.*;
    import net.noiseinstitute.youarenowinspace.entities.Border;
    import net.noiseinstitute.youarenowinspace.entities.Player;
    import net.noiseinstitute.youarenowinspace.entities.Score;

    public class Level3 extends World {

        private static const PLAY_WIDTH:int = 320;
        private static const PLAY_HEIGHT:int = 200;

        private var playX:int = (FP.screen.width - PLAY_WIDTH)/2;
        private var playY:int = (FP.screen.height - PLAY_HEIGHT)/2;

        private var stage:int;

        private var player:Player;
        private var alienSpawner:AlienSpawner;

        private var time:int;

        [Embed(source="Alert.mp3")]
        private static var ALERT:Class;

        public var alertChannel:SoundChannel = Sound(new ALERT()).play(0, int.MAX_VALUE);

        public function Level3 (stage:int) {
            super();

            time = 120*stage;

            this.stage = stage;

            alienSpawner = new AlienSpawner(stage, playX, playY, PLAY_WIDTH, PLAY_HEIGHT);

            player = new Player();
            player.x = playX + (PLAY_WIDTH - player.width)/2;
            player.y = playY;
            add(player);

            var me:Level3 = this;
            player.onDie = function():void {
                me.finish(new Intermission(stage));
            };

            var border:Border = new Border();
            border.x = -(Border.WIDTH - FP.screen.width) / 2;
            border.y = -(Border.HEIGHT - FP.screen.height) / 2;
            border.layer = -1;
            border.alert = true;
            add(border);

            var score:Score = new Score();
            score.layer = -2;
            add(score);
        }

        override public function update ():void {
            super.update();
            alienSpawner.update();

            if (--time <= 0) {
                finish();

            }
        }

        private function finish (world:World = null):void {
            if (world == null) {
                world = new GetReadyWorld(stage + 1)
            }
            alertChannel.stop();
            FP.world = world;
        }
    }
}