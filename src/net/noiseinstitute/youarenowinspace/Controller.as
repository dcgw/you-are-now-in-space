package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.noiseinstitute.youarenowinspace.entities.Bullet;

	public class Controller {
		
		private const SHOOT_INTERVAL:uint = 6;

		[Embed(source = 'data/laser.mp3')]
		private const LASER_SOUND:Class;
		
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
			if(Input.pressed(Key.SPACE)) {
				if(_controlled.hasElapsed(SHOOT_INTERVAL)) {
					FP.world.add(new Bullet(_controlled.centerX, _controlled.centerY));
                    new Sfx(LASER_SOUND).play();
					_controlled.resetTime();
				}
			}
		}
	}
}