package net.noiseinstitute.youarenowinspace.worlds {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class TitleWorld extends World {

        [Embed(source="Title.png")]
        private const TITLE_IMAGE:Class;

        public function TitleWorld() {
            var entity:Entity = new Entity();
            var spritemap:Spritemap = new Spritemap(TITLE_IMAGE);
            spritemap.add("click", [0], 1);
            spritemap.add("press", [1], 1);
            spritemap.play("click");
            entity.graphic = spritemap;
            add(entity);
        }

        override public function update():void {
            super.update();
            if (Input.pressed(Key.X) || Input.pressed(Key.SPACE)) {
                FP.world = new Level1();
            }
        }
    }
}
