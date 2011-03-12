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

        public function Level3AlienBehaviour (alien:Alien) {
            this.alien = alien;
            pos = Math.random() * (Math.PI * 2);

            pathX = (Math.random() * FP.screen.width/2) + FP.screen.width/4;
            pathY = (Math.random() * FP.screen.height/2) + FP.screen.height/4;
            pathW = Math.random() * pathX - FP.screen.width/4;
            pathH = Math.random() * pathY - FP.screen.height/4;
        }

        public function update ():void {
            pos += 0.1;
            alien.x = pathX + pathW * Math.cos(pos);
            alien.y = pathY + pathH * Math.sin(pos);
        }
    }
}
