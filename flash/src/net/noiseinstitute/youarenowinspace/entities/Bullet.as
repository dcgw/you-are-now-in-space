package net.noiseinstitute.youarenowinspace.entities {
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.youarenowinspace.YANISEntity;

    public class Bullet extends YANISEntity {

        [Embed(source = 'Bullet.png')]
        private const BULLET_IMAGE:Class;

        private static const WIDTH:int = 5;
        private static const HEIGHT:int = 10;

        public function Bullet (x:Number = 0, y:Number = 0) {
            this.x = x - WIDTH / 2;
            this.y = y - HEIGHT / 2;
            graphic = new Image(BULLET_IMAGE);
            setHitbox(WIDTH, HEIGHT);
            type = "bullet";
        }

        override public function update ():void {
            y += 10;

            // If a bullet goes off screen, get rid of it
            if (y >= FP.screen.height + height) {
                FP.world.remove(this);
            }
        }

        public function destroy ():void {
            FP.world.remove(this);
        }
    }
}