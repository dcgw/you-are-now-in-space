package net.noiseinstitute.youarenowinspace.worlds {
    import flash.events.Event;
    import flash.media.SoundChannel;

    import net.flashpunk.FP;
    import net.flashpunk.World;

    public class GetReadyWorld extends World {

        [Embed(source="GetReady.mp3")]
        private static const MUSIC:Class;

        public function GetReadyWorld () {
            var musicChannel:SoundChannel = new MUSIC().play();
            musicChannel.addEventListener(Event.SOUND_COMPLETE, function(e:Event):void {
                FP.world = new Level1();
            });
        }

    }
}
