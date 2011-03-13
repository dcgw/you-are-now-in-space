package net.noiseinstitute.youarenowinspace.worlds {
    import flash.events.Event;
    import flash.events.GesturePhase;
    import flash.media.SoundChannel;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Spritemap;
    import net.noiseinstitute.youarenowinspace.behaviours.ResettableTimer;

    import spark.primitives.Rect;

    public class GetReadyWorld extends World {

        [Embed(source="GetReady.mp3")]
        private static const MUSIC:Class;

        [Embed(source="GetReady.png")]
        private static const SPRITEMAP:Class;

        private static const SPRITEMAP_WIDTH:int = 104;
        private static const SPRITEMAP_HEIGHT:int = 8;

        private var stage:int;

        private var timer:ResettableTimer = new ResettableTimer();

        private var getReadySpritemap:Spritemap;
        private var getReadyEntity:Entity;

        private var stageSpritemap:Spritemap;
        private var stageEntity:Entity;

        public function GetReadyWorld (stage:int) {
            this.stage = stage;
            
            var musicChannel:SoundChannel = new MUSIC().play();
            musicChannel.addEventListener(Event.SOUND_COMPLETE, function(e:Event):void {
                if (stage%2 == 0) {
                    FP.world = new Level3(stage);
                } else {
                    FP.world = new Level1(stage);
                }
            });

            getReadySpritemap = new Spritemap(SPRITEMAP, SPRITEMAP_WIDTH, SPRITEMAP_HEIGHT);
            getReadySpritemap.add("white", [0], 1);
            getReadySpritemap.add("fail", [1], 1);
            getReadySpritemap.add("glow", [13,6,7,12,0,12,7,6], 0.25);
            getReadySpritemap.play("white");

            stageSpritemap = new Spritemap(SPRITEMAP, SPRITEMAP_WIDTH, SPRITEMAP_HEIGHT);
            stageSpritemap.add("one-white", [2], 1);
            stageSpritemap.add("three-white", [4], 1);
            stageSpritemap.add("one-fail", [3], 1);
            stageSpritemap.add("three-fail", [5], 1);
            stageSpritemap.add("one-glow", [9,14,2,14,9,8,15], 0.25);
            stageSpritemap.add("three-glow", [11,16,4,16,11,10,16], 0.25);

            getReadyEntity = new Entity();
            getReadyEntity.graphic = getReadySpritemap;
            getReadyEntity.x = (FP.screen.width - 320)/2 + 96;
            getReadyEntity.y = (FP.screen.height - 200)/2 + 64;

            stageEntity = new Entity();
            stageEntity.graphic = stageSpritemap;
            stageEntity.x = getReadyEntity.x;
            stageEntity.y = getReadyEntity.y + 16;

            if (stage == 1) {
                stageSpritemap.play("one-white");
            } else if (stage == 2) {
                stageSpritemap.play("three-white");
            } else {
                stageEntity.visible = false;
            }

            add(getReadyEntity);
            add(stageEntity);
        }

        override public function update():void {
            super.update();
            timer.update();

            if (timer.hasElapsed(180)) {
                getReadySpritemap.play("fail");
                if (stage == 1) {
                    stageSpritemap.play("one-fail");
                } else if (stage == 2) {
                    stageSpritemap.play("three-fail");
                }
            } else if (timer.hasElapsed(2)) {
                getReadySpritemap.play("glow");
                if (stage == 1) {
                    stageSpritemap.play("one-glow");
                } else if (stage == 2) {
                    stageSpritemap.play("three-glow");
                }
            }
        }
    }
}
