package net.noiseinstitute.youarenowinspace.behaviours
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.noiseinstitute.youarenowinspace.Controller;
	import net.noiseinstitute.youarenowinspace.entities.Alien;

	public class BrokenFormationBehaviour implements IBehaviour {
		
		private const SPEED:Number = 4;
		
		private var alien:Alien;
		private var layer:Number;
		
		public function BrokenFormationBehaviour(alien:Alien) {
			this.alien = alien;
			layer = (Math.random() * 3) + 2;
		}
		
		public function update():void {
			alien.y -= SPEED;
			if(alien.y <= -Alien.HEIGHT) {
				alien.y = FP.screen.height;
			}
		}
		
		public function execute(cmd:int):void {
			switch(cmd) {
				case Controller.LEFT:
					alien.x -= layer;
					break;
				case Controller.RIGHT:
					alien.x += layer;
			}
		}
	}
}