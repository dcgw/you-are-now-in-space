package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.Entity;

	public class ControllableEntity extends YANISEntity implements IControllable {
		
		private var _controller:Controller;
		
		public function ControllableEntity() {
			super();
		}
		
		public function execute(cmd:int):void {
			switch(cmd) {
				case Controller.UP:
					y -= 5;
					break;
				case Controller.DOWN:
					y += 5;
					break;
				case Controller.LEFT:
					x -= 5;
					break;
				case Controller.RIGHT:
					x += 5;
					break;
			}
		}
	}
}