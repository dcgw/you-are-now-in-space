package net.noiseinstitute.youarenowinspace.entities {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class AlienBullet extends Entity {
        [Embed(source = 'AlienBullet.png')]
        private const IMAGE:Class;

        private const WIDTH:int = 5;
        private const HEIGHT:int = 5;

        private var vx:Number;
        private var vy:Number;

        public function AlienBullet (x:int=0, y:int=0, vx:Number=0, vy:Number=0) {
            super();

            graphic = new Image(IMAGE);

            this.x = x - WIDTH/2;
            this.y = y - HEIGHT/2;
            this.vx = vx;
            this.vy = vy;

            width = WIDTH;
            height = HEIGHT;

            type = "deadly";
            setHitbox(WIDTH, HEIGHT);
        }
        
        override public function update():void {
            super.update();
            x += vx;
            y += vy;

            if (x < 0 || x > FP.screen.width || y < 0 || y > FP.screen.height) {
                FP.world.remove(this);
            }
        }
    }
}
