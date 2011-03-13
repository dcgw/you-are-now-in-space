package net.noiseinstitute.youarenowinspace.entities {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;

    public class Border extends Entity {
        [Embed(source="Border.png")]
        private static const BORDER:Class;

        public static const WIDTH:int = 384;
        public static const HEIGHT:int = 288;

        private var spritemap:Spritemap = new Spritemap(BORDER, WIDTH, HEIGHT);

        private var _alert:Boolean = false;

        public function get alert():Boolean {
            return _alert;
        }

        public function set alert(value:Boolean):void {
            _alert = value;
            if (value) {
                spritemap.play("alert");
            } else {
                spritemap.play("black");
            }
        }

        public function Border () {
            spritemap.add("black", [0], 1);
            spritemap.add("alert", [0,1,2,3,4,5,6,5,4,3,2,1], 0.25);
            spritemap.play("black");
            graphic = spritemap;
        }
    }
}
