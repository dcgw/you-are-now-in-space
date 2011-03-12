package net.noiseinstitute.youarenowinspace
{
    import net.flashpunk.World;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class Level3 extends World {
		
		private var player:Player;
		private var alienSpawner:AlienSpawner;
		
		public function Level3() {
			super();
			
			alienSpawner = new AlienSpawner();
			
			player = new Player();
			add(player)
			var ctrl:Controller = new Controller(player);
		}
		
		override public function update():void {
			super.update();
			alienSpawner.update();
		}
	}
}