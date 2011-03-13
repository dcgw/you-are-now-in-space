package net.noiseinstitute.youarenowinspace.worlds {
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import net.flashpunk.World;
    import net.noiseinstitute.youarenowinspace.*;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class Level3 extends World {

        private var player:Player;
        private var alienSpawner:AlienSpawner;

        [Embed(source="Alert.mp3")]
        private static var ALERT:Class;

        public var alertChannel:SoundChannel = Sound(new ALERT()).play(0, int.MAX_VALUE);

        public function Level3 () {
            super();

            alienSpawner = new AlienSpawner();

            player = new Player();
            add(player);
        }

        override public function update ():void {
            super.update();
            alienSpawner.update();
        }
    }
}