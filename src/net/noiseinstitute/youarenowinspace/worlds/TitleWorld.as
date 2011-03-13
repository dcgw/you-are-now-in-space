package net.noiseinstitute.youarenowinspace.worlds {
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
    import net.noiseinstitute.youarenowinspace.Main;

    public class TitleWorld extends World {

        [Embed(source="Title.png")]
        private const TITLE:Class;

        [Embed(source="TitleImage.png")]
        private const TITLE_IMAGE:Class;

        [Embed(source="Title.mp3")]
        private const TITLE_MUSIC:Class;

        private static const TITLE_WIDTH:int = 176;
        private static const TITLE_HEIGHT:int = 32;

        private static const TITLE_IMAGE_WIDTH:int = 320;
        private static const TITLE_IMAGE_HEIGHT:int = 200;

        private var _titleImageSpritemap:Spritemap = new Spritemap(TITLE_IMAGE, TITLE_IMAGE_WIDTH, TITLE_IMAGE_HEIGHT);
        private var listening:Boolean = false;
        private var music:SoundChannel = Sound(new TITLE_MUSIC()).play(0, int.MAX_VALUE);

        public function TitleWorld () {
            FP.screen.color = 0xff444444;

            Main.score = 0;

            var titleImage:Entity = new Entity();
            _titleImageSpritemap.add("click", [0], 1);
            _titleImageSpritemap.add("press", [1], 1);
            _titleImageSpritemap.play("click");
            titleImage.graphic = _titleImageSpritemap;
            titleImage.x = (FP.screen.width - TITLE_IMAGE_WIDTH) / 2;
            titleImage.y = (FP.screen.height - TITLE_IMAGE_HEIGHT) / 2;
            add(titleImage);

            var title:Entity = new Entity();
            var titleSpritemap:Spritemap = new Spritemap(TITLE, TITLE_WIDTH, TITLE_HEIGHT);
            titleSpritemap.add("glowing", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16], 0.25);
            titleSpritemap.play("glowing");
            title.graphic = titleSpritemap;
            title.x = titleImage.x + 8;
            title.y = titleImage.y + 8;
            add(title);
        }

        override public function update ():void {
            super.update();
            if (Input.pressed("fire")) {
                music.stop();
                FP.world = new GetReadyWorld(1);

                if (listening) {
                    FP.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onFocus);
                    FP.stage.removeEventListener(Event.ACTIVATE, onFocus);
                    FP.stage.removeEventListener(Event.DEACTIVATE, onBlur);
                }
            }

            if (!listening) {
                FP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onFocus);
                FP.stage.addEventListener(Event.ACTIVATE, onFocus);
                FP.stage.addEventListener(Event.DEACTIVATE, onBlur);
                listening = true;
            }
        }

        private function onFocus (e:Event):void {
            _titleImageSpritemap.play("press");
        }

        private function onBlur (e:Event):void {
            _titleImageSpritemap.play("click");
        }
    }
}
