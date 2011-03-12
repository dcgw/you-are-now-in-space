package net.noiseinstitute.youarenowinspace
{
	import flash.utils.Dictionary;
	
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.noiseinstitute.youarenowinspace.entities.Bullet;

	public class Controller {
		
		public static const UP:int = 1;
		public static const DOWN:int = 2;
		public static const LEFT:int = 4;
		public static const RIGHT:int = 8;
		public static const SHOOT:int = 16;

		private var _controlled:Vector.<IControllable> = new Vector.<IControllable>();
		private var _controls:Dictionary = new Dictionary();
		
		public function Controller() {
		}
		
		public function register(target:IControllable, cmds:int = -1):void {
			if(cmds == -1) {
				cmds = UP | DOWN | LEFT | RIGHT | SHOOT;
			}
			
			_controlled[_controlled.length] = target;
			_controls[target] = cmds;
		}
		
		public function giveControl(target:IControllable, cmds:int):void {
			_controls[target] |= cmds;
		}
		
		public function releaseControl(target:IControllable, cmds:int):void {
			_controls[target] &= ~cmds;
		}
		
		private function hasCmd(target:IControllable, cmd:int):Boolean {
			return (_controls[target] & cmd) == cmd;
		}
		
		public function control():void {
			var up:Boolean = Input.check(Key.UP);
			var down:Boolean = Input.check(Key.DOWN);
			var left:Boolean = Input.check(Key.LEFT);
			var right:Boolean = Input.check(Key.RIGHT);
			var shoot:Boolean = Input.pressed(Key.SPACE) || Input.pressed(Key.X);
			
			for each(var target:IControllable in _controlled) {
				if(up && hasCmd(target, UP)) {
					target.execute(UP);
				}
				if(down && hasCmd(target, DOWN)) {
					target.execute(DOWN);
				}
				if(left && hasCmd(target, LEFT)) {
					target.execute(LEFT);
				}
				if(right && hasCmd(target, RIGHT)) {
					target.execute(RIGHT);
				}
				if(shoot && hasCmd(target, SHOOT)) {
					target.execute(SHOOT);
				}
			}
		}
	}
}