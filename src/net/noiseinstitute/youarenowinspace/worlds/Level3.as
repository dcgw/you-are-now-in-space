package net.noiseinstitute.youarenowinspace.worlds
{
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import net.flashpunk.World;
    import net.noiseinstitute.youarenowinspace.*;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class Level3 extends World {
		
		private var player:Player;
		private var alienSpawner:AlienSpawner;

        [Embed(source="Level3.mp3")]
        private static var EAR_PAIN:Class;

        public var earPain:SoundChannel = Sound(new EAR_PAIN()).play(0, int.MAX_VALUE);

        private var _controller:Controller;

        public function Level3() {
			super();
			
			alienSpawner = new AlienSpawner();
			
			player = new Player();
			add(player);

            _controller = new Controller(player);
		}
		
		override public function update():void {
			super.update();
			alienSpawner.update();
            _controller.control();
		}
	}
}