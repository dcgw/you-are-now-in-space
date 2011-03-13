package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
    import net.noiseinstitute.youarenowinspace.worlds.TitleWorld;


    [SWF(width="640", height="480", backgroundColor="#000000", frameRate="60")]
	public class Main extends Engine {
		
		public function Main() {
			super(320, 200, 60, true);
            FP.screen.scale = 2;
			FP.world = new TitleWorld();
		}
    } 
} 