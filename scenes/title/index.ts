import {Actor, Color, Input, Scene, SpriteSheet, Vector} from "excalibur";
import Score from "../../actors/score";
import Game from "../../game";
import resources from "../../resources";

const backgroundImageWidth = 320;
const backgroundImageHeight = 200;

const titleWidth = 176;
const titleHeight = 32;

export default class Title extends Scene {
    private readonly titleImage: Actor;

    constructor(private readonly game: Game) {
        super(game.engine);

        this.titleImage = new Actor({
            x: (game.width - backgroundImageWidth) * .5,
            y: (game.height - backgroundImageHeight) * .5,
            width: backgroundImageWidth,
            height: backgroundImageHeight,
            anchor: Vector.Zero,
        });
        const titleImageSpriteSheet = new SpriteSheet({
            image: resources.titleBackground,
            spWidth: backgroundImageWidth,
            spHeight: backgroundImageHeight,
            rows: 1,
            columns: 2
        });
        this.titleImage.addDrawing("click", titleImageSpriteSheet.getSprite(0));
        this.titleImage.addDrawing("press", titleImageSpriteSheet.getSprite(1));
        this.add(this.titleImage);

        const title = new Actor({
            x: this.titleImage.x + 8,
            y: this.titleImage.y + 8,
            width: titleWidth,
            height: titleHeight,
            anchor: Vector.Zero
        });
        title.addDrawing("glowing",
            new SpriteSheet({
                image: resources.title,
                spWidth: titleWidth,
                spHeight: titleHeight,
                rows: 17,
                columns: 1
            }).getAnimationForAll(game.engine, 4 * 1000 / 60));
        this.add(title);

        this.add(new Score(game));
    }

    public onActivate(): void {
        this.game.engine.backgroundColor = Color.fromHex("444444");
        this.game.engine.input.keyboard.on("press", this.onKeyPress);
    }

    public onDeactivate(): void {
        resources.titleMusic.stop();
        this.game.engine.input.keyboard.off("press", this.onKeyPress as any);
    }


    public update(): void {
        if (this.game.active) {
            if (!resources.titleMusic.isPlaying()) {
                resources.titleMusic.loop = true;
                resources.titleMusic.play()
                    .then(() => void 0,
                        reason => console.error("", reason));
            }
            this.titleImage.setDrawing("press");
        } else {
            this.titleImage.setDrawing("click");
        }
    }

    private readonly onKeyPress = (event?: Input.KeyEvent) => {
        if (event != null && event.key === Input.Keys.X) {
            this.game.reset();
            this.game.engine.goToScene("get-ready");
        }
    }
}