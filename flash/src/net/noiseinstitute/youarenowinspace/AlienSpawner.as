package net.noiseinstitute.youarenowinspace {
    import net.flashpunk.FP;
    import net.noiseinstitute.youarenowinspace.behaviours.Level3AlienBehaviour;
    import net.noiseinstitute.youarenowinspace.entities.Alien;

    public class AlienSpawner {

        private const SPAWN_INTERVAL:uint = 160;

        private var time:uint = 0;

        private const COLOURS:Vector.<String> = Vector.<String>([
            Alien.RED, Alien.GREEN, Alien.BROWN, Alien.GREY]);

        private var stage:int;

        private var playX:int;
        private var playY:int;
        private var playWidth:int;
        private var playHeight:int;

        public function AlienSpawner(stage:int, playX:int, playY:int, playWidth:int, playHeight:int) {
            this.stage = stage;
            this.playX = playX;
            this.playY = playY;
            this.playWidth = playWidth;
            this.playHeight = playHeight;
        }

        private function spawnAlien ():void {
            var colour:String = COLOURS[Math.floor(Math.random() * COLOURS.length)];
            var alien:Alien = new Alien(colour);
            alien.behaviour = new Level3AlienBehaviour(alien, stage, playX, playY, playWidth, playHeight);

            alien.onDie = function():void {
                Main.score += 100*stage;
            }

            FP.world.add(alien);
            time = 0;
        }

        public function update ():void {
            time += stage;
            if (time >= SPAWN_INTERVAL) {
                spawnAlien();
            }
        }
    }
}