package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class YANISEntity extends Entity {
		
		private var _time:uint = 0;
		
		public function YANISEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
			super(x, y, graphic, mask);
		}
		
		public function get time():uint {
			return _time;
		}
		
		public function hasElapsed(period:uint):Boolean {
			return _time >= period;
		}
		
		public function resetTime():void {
			_time = 0;
		}
		
		override public function update():void {
			super.update();
			_time++;
		}
	}
}