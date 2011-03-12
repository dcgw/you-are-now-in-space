package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine {
		
		public function Main() {
			super(800, 600, 60, false);
			FP.world = new YANISWorld();
		}
		
		override public function init():void {
			trace("FlashPunk has started successfully!");
		}
    } 
} 