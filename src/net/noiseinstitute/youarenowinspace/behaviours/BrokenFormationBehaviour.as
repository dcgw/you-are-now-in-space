package net.noiseinstitute.youarenowinspace.behaviours
{
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;
    import net.noiseinstitute.youarenowinspace.entities.Alien;

    public class BrokenFormationBehaviour implements IBehaviour {
		
		private const SPEED:Number = 1.5;
		
		private var alien:Alien;
		private var layer:Number;
		
		public function BrokenFormationBehaviour(alien:Alien) {
			this.alien = alien;
			layer = (Math.random() * 3) + 2;
		}
		
		public function update():void {
			alien.y -= SPEED * layer;

            if (Input.check("left")) {
                alien.x -= layer;
            }

            if (Input.check("right")) {
                alien.x += layer;
			}

			// Wrap
			if (alien.y <= -Alien.HEIGHT) {
				alien.y += FP.screen.height;
			}
			if (alien.x <= -Alien.WIDTH) {
				alien.x += FP.screen.width;
			}
			if (alien.x >= FP.screen.width) {
				alien.x -= FP.screen.width;
			}
		}
	}
}