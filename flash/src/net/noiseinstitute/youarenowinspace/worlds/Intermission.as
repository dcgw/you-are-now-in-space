package net.noiseinstitute.youarenowinspace.worlds {
    import flash.events.Event;
    import flash.media.SoundChannel;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.youarenowinspace.Main;
    import net.noiseinstitute.youarenowinspace.behaviours.ResettableTimer;
    import net.noiseinstitute.youarenowinspace.entities.Score;

    public class Intermission extends World {

        [Embed(source="Intermission.mp3")]
        private static const MUSIC:Class;

        [Embed(source="intermission.png")]
        private static const SPRITEMAP:Class;

        private static const SPRITEMAP_WIDTH:int = 128;
        private static const SPRITEMAP_HEIGHT:int = 8;

        private var stage:int;

        private var timer:ResettableTimer = new ResettableTimer();
        private var spritemap:Spritemap;

        public function Intermission (stage:int) {
            this.stage = stage;

            --Main.lives;

            var musicChannel:SoundChannel = new MUSIC().play();
            musicChannel.addEventListener(Event.SOUND_COMPLETE, function(e:Event):void {
                if (Main.lives > 0) {
                    if (stage%2 == 0) {
                        FP.world = new Level3(stage);
                    } else {
                        FP.world = new Level1(stage);
                    }
                } else {
                    FP.world = new TitleWorld();
                }
            });

            spritemap = new Spritemap(SPRITEMAP, SPRITEMAP_WIDTH, SPRITEMAP_HEIGHT);
            spritemap.add("3", [0], 1);
            spritemap.add("2", [1], 1);
            spritemap.add("1", [2], 1);
            spritemap.add("0", [3], 1);
            spritemap.add("3fail", [4], 1);
            spritemap.add("2fail", [5], 1);
            spritemap.add("1fail", [6], 1);
            spritemap.add("0fail", [7], 1);
            spritemap.play(Main.lives.toString(10));

            var entity:Entity = new Entity();
            entity.graphic = spritemap;
            entity.x = (FP.screen.width - 320)/2 + 96;
            entity.y = (FP.screen.height - 200)/2 + 64;
            add(entity);

            add(new Score());
        }

        override public function update():void {
            super.update();
            timer.update();

            if (timer.hasElapsed(180)) {
                spritemap.play(Main.lives.toString(10) + "fail");
            }
        }
    }
}
