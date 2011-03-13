package net.noiseinstitute.youarenowinspace.entities {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Text;
    import net.noiseinstitute.youarenowinspace.Main;

    public class Score extends Entity {
        private var text:Text;

        public function Score () {
            x = (FP.screen.width - 320) / 2;
            y = (FP.screen.height - 200) / 2 + 200 + 8;

            text = new Text("0", 0, 0, 320);
            text.font = "C64";
            text.size = 16;
            graphic = text;
        }

        override public function update ():void {
            text.text = Main.score.toString(10);
        }
    }
}
