package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.World;
	import net.noiseinstitute.youarenowinspace.entities.Alien;
	import net.noiseinstitute.youarenowinspace.entities.Player;
	
	public class Space extends World {
		
		private var player:Player;
		
		public function Space() {
			super();
			add(new Alien());
			player = new Player();
			add(player)
			var ctrl:Controller = new Controller(player);
		}
	}
}