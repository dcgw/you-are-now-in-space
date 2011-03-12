package net.noiseinstitute.youarenowinspace.worlds {
    import flash.events.Event;

    import flash.events.MouseEvent;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class TitleWorld extends World {

        [Embed(source="Title.png")]
        private const TITLE_IMAGE:Class;

        private var _spritemap:Spritemap = new Spritemap(TITLE_IMAGE, 320, 200);
        private var listening:Boolean = false;

        public function TitleWorld() {
            var entity:Entity = new Entity();
            _spritemap.add("click", [0], 1);
            _spritemap.add("press", [1], 1);
            _spritemap.play("click");
            entity.graphic = _spritemap;
            add(entity);
        }

        override public function update():void {
            super.update();
            if (Input.pressed(Key.X) || Input.pressed(Key.SPACE)) {
                FP.world = new Level1();

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

        private function onFocus(e:Event):void {
            _spritemap.play("press");
        }

        private function onBlur(e:Event):void {
            _spritemap.play("click");
        }
    }
}
