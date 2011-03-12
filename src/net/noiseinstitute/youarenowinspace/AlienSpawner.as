package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.FP;
    import net.noiseinstitute.youarenowinspace.behaviours.Level3AlienBehaviour;
    import net.noiseinstitute.youarenowinspace.entities.Alien;

	public class AlienSpawner {
		
		private const SPAWN_INTERVAL:uint = 40;
		
		private var time:uint = 0;

        private const COLOURS:Vector.<String> = Vector.<String>([
                Alien.RED, Alien.GREEN, Alien.BROWN, Alien.GREY]);
		
		public function spawnAlien():void {
            var colour:String = COLOURS[Math.floor(Math.random() * COLOURS.length)];
			var alien:Alien = new Alien(colour);
            alien.behaviour = new Level3AlienBehaviour(alien);
			FP.world.add(alien);
			time = 0;
		}
		
		public function update():void {
			time++;
			if(time >= SPAWN_INTERVAL) {
				spawnAlien();
			}
		}
	}
}