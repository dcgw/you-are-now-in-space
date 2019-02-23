import {Actor, Color, Engine, Scene, SpriteSheet, Vector} from "excalibur";
import resources from "../../resources";

const TITLE_IMAGE_WIDTH = 320;
const TITLE_IMAGE_HEIGHT = 200;

const TITLE_WIDTH = 176;
const TITLE_HEIGHT = 32;

export default class Title extends Scene {
    constructor(private engine: Engine) {
        super(engine);

        const titleImage = new Actor({
            x: (engine.canvasWidth - TITLE_IMAGE_WIDTH) * .5,
            y: (engine.canvasHeight - TITLE_IMAGE_HEIGHT) * .5,
            width: TITLE_IMAGE_WIDTH,
            height: TITLE_IMAGE_HEIGHT,
            anchor: Vector.Zero,
        });
        const titleImageSpriteSheet = new SpriteSheet({
            image: resources.titleImage,
            spWidth: TITLE_IMAGE_WIDTH,
            spHeight: TITLE_IMAGE_HEIGHT,
            rows: 1,
            columns: 2
        });
        titleImage.addDrawing(titleImageSpriteSheet.getSprite(0));
        titleImage.addDrawing("press", titleImageSpriteSheet.getSprite(1));
        this.add(titleImage);

        const title = new Actor({
            x: titleImage.x + 8,
            y: titleImage.y + 8,
            width: TITLE_WIDTH,
            height: TITLE_HEIGHT,
            anchor: Vector.Zero
        });
        title.addDrawing("glowing",
            new SpriteSheet({
                image: resources.title,
                spWidth: TITLE_WIDTH,
                spHeight: TITLE_HEIGHT,
                rows: 17,
                columns: 1
            }).getAnimationForAll(engine, 4 * 1000 / 60));
        title.setDrawing("glowing");
        this.add(title);
    }

    public onActivate(): void {
        this.engine.backgroundColor = Color.fromHex("444444");
    }
}