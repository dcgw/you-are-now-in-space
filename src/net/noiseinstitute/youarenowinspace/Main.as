package net.noiseinstitute.youarenowinspace {
    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    import net.noiseinstitute.youarenowinspace.worlds.TitleWorld;

    [SWF(width="768", height="576", backgroundColor="#000000", frameRate="60")]
    public class Main extends Engine {

        public function Main () {
            super(384, 288, 60, true);

            Input.define("left", Key.LEFT);
            Input.define("right", Key.RIGHT);
            Input.define("up", Key.UP);
            Input.define("down", Key.DOWN);
            Input.define("fire", Key.X, Key.Z, Key.SPACE);

            FP.screen.scale = 2;
            FP.world = new TitleWorld();
        }
    }
} 