package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.Entity;

	public class ControllableEntity extends Entity {
		
		private var _controller:Controller;
		
		public function ControllableEntity() {
			super();
		}
		
		public function giveControl(_controller:Controller):void {
			this._controller = _controller;
		}

		public function releaseControl():void {
			_controller = null;
		}
		
		override public function update():void {
			super.update();
			
			if(_controller != null) {
				_controller.control();
			}
		}
	}
}