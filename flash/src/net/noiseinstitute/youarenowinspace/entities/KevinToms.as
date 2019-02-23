package net.noiseinstitute.youarenowinspace.entities {
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.youarenowinspace.YANISEntity;

    public class KevinToms extends YANISEntity {

        [Embed(source='KevinToms.png')]
        private static const KEVIN_TOMS:Class;

        public function KevinToms () {
            graphic = new Image(KEVIN_TOMS);
        }
    }
}
