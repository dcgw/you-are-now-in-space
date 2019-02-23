package net.noiseinstitute.youarenowinspace.behaviours {
    import net.flashpunk.FP;
    import net.noiseinstitute.youarenowinspace.entities.Alien;

    public class Level3AlienBehaviour implements IBehaviour {

        private var alien:Alien;
        private var pos:Number;

        private var pathX:Number;
        private var pathY:Number;
        private var pathW:Number;
        private var pathH:Number;

        private var stage:int;

        private var playX:int;
        private var playY:int;
        private var playWidth:int;
        private var playHeight:int;

        public function Level3AlienBehaviour (alien:Alien, stage:int, playX:int, playY:int, playWidth:int, playHeight:int) {
            this.alien = alien;

            this.stage = stage;
            this.playX = playX;
            this.playY = playY;
            this.playWidth = playWidth;
            this.playHeight = playHeight;

            // deliberately glitch the alien to the top-left in the first frame :)
            alien.x = playX;
            alien.y = playY;

            pos = Math.random() * (Math.PI * 2);

            pathX = (Math.random() * playWidth / 2) + playWidth / 4;
            pathY = (Math.random() * playHeight / 2) + playHeight / 4;
            pathW = Math.random() * pathX - playWidth / 4;
            pathH = Math.random() * pathY - playHeight / 4;
        }

        public function update ():void {
            pos += 0.02 * stage;
            alien.x = playX + pathX + pathW * Math.cos(pos);
            alien.y = playY + pathY + pathH * Math.sin(pos);
        }
    }
}
