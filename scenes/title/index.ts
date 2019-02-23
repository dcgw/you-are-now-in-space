import {Actor, Color, Engine, Input, Scene, SpriteSheet, Vector} from "excalibur";
import {HEIGHT, WIDTH} from "../..";
import resources from "../../resources";

const TITLE_IMAGE_WIDTH = 320;
const TITLE_IMAGE_HEIGHT = 200;

const TITLE_WIDTH = 176;
const TITLE_HEIGHT = 32;

export default class Title extends Scene {
    private titleImage: Actor;

    constructor(private engine: Engine) {
        super(engine);

        this.titleImage = new Actor({
            x: (WIDTH - TITLE_IMAGE_WIDTH) * .5,
            y: (HEIGHT - TITLE_IMAGE_HEIGHT) * .5,
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
        this.titleImage.addDrawing("click", titleImageSpriteSheet.getSprite(0));
        this.titleImage.addDrawing("press", titleImageSpriteSheet.getSprite(1));
        this.add(this.titleImage);

        const title = new Actor({
            x: this.titleImage.x + 8,
            y: this.titleImage.y + 8,
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
        this.add(title);
    }

    public onActivate(): void {
        this.engine.backgroundColor = Color.fromHex("444444");
        this.engine.input.pointers.primary.on("up", this.onClick);
        this.engine.input.keyboard.on("press", this.onKeyPress);
        window.addEventListener("blur", this.onBlur, true);
    }

    public onDeactivate(): void {
        resources.titleMusic.stop();
        this.engine.input.pointers.primary.off("up", this.onClick);
        this.engine.input.keyboard.off("press", this.onKeyPress as any);
        window.removeEventListener("blur", this.onBlur, true);
    }

    private onClick = () => {
        if (!resources.titleMusic.isPlaying()) {
            resources.titleMusic.loop = true;
            resources.titleMusic.play()
                .then(() => void 0,
                    reason => console.error("", reason));
        }
        this.titleImage.setDrawing("press");
    }

    private onKeyPress = (event?: Input.KeyEvent) => {
        if (event != null && event.key === Input.Keys.X) {
            this.engine.goToScene("get-ready");
        }
    }

    private onBlur = () => this.titleImage.setDrawing("click");
}