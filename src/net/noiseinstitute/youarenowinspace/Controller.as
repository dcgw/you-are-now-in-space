package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Controller {
		
		private var _controlled:ControllableEntity;
		
		public function Controller(entity:ControllableEntity) {
			controlEntity(entity);
		}
		
		public function controlEntity(entity:ControllableEntity):void {
			if(_controlled != null) {
				_controlled.releaseControl();
			}
			_controlled = entity;
			_controlled.giveControl(this);
		}
		
		public function control():void {
			if(Input.check(Key.UP)) {
				_controlled.y -= 5;
			}
			if(Input.check(Key.DOWN)) {
				_controlled.y += 5;
			}
			if(Input.check(Key.LEFT)) {
				_controlled.x -= 5;
			}
			if(Input.check(Key.RIGHT)) {
				_controlled.x += 5;
			}
		}
	}
}