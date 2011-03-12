package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.FP;
	import net.noiseinstitute.youarenowinspace.entities.Alien;

	public class AlienSpawner {
		
		private const SPAWN_INTERVAL:uint = 40;
		
		private var time:uint = 0;
		
		public function AlienSpawner() {
		}
		
		public function spawnAlien():void {
			var alien:Alien = new Alien();
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