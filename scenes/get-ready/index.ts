import {Actor, Engine, Scene, SpriteSheet, Timer, Vector} from "excalibur";
import {HEIGHT, WIDTH} from "../../index";
import resources from "../../resources";

const spriteSheetWidth = 104;
const spriteSheetHeight = 8;

const spriteSheet = new SpriteSheet({
    image: resources.getReady,
    spWidth: spriteSheetWidth,
    spHeight: spriteSheetHeight,
    rows: 10,
    columns: 2
});

export default class GetReady extends Scene {
    private getReady = new Actor({
        x: (WIDTH - 320) * .5 + 96,
        y: (HEIGHT - 200) * .5 + 64,
        width: spriteSheetWidth,
        height: spriteSheetHeight,
        anchor: Vector.Zero
    });

    private stageText = new Actor({
        x: this.getReady.x,
        y: this.getReady.y + 16,
        width: spriteSheetWidth,
        height: spriteSheetHeight,
        anchor: Vector.Zero
    });

    constructor(private engine: Engine, private stage: number) {
        super(engine);

        this.getReady.addDrawing("white", spriteSheet.getSprite(0));
        this.getReady.addDrawing("fail", spriteSheet.getSprite(1));
        this.getReady.addDrawing("glow", spriteSheet.getAnimationByIndices(engine,
            [13, 6, 7, 12, 0, 12, 7, 6], 4 * 1000 / 60));
        this.add(this.getReady);

        this.stageText.addDrawing("one-white", spriteSheet.getSprite(2));
        this.stageText.addDrawing("three-white", spriteSheet.getSprite(4));
        this.stageText.addDrawing("one-fail", spriteSheet.getSprite(3));
        this.stageText.addDrawing("three-fail", spriteSheet.getSprite(5));
        this.stageText.addDrawing("one-glow", spriteSheet.getAnimationByIndices(engine,
            [9, 14, 2, 14, 9, 8, 15], 4 * 1000 / 60));
        this.stageText.addDrawing("three-glow", spriteSheet.getAnimationByIndices(engine,
            [11, 16, 4, 16, 11, 10, 16], 4 * 1000 / 60));
        this.add(this.stageText);
    }

    public onActivate(): void {
        resources.getReadyMusic.play()
            .then(() => this.engine.goToScene("title"),
                reason => console.error("", reason));

        if (this.stage === 1) {
            this.stageText.setDrawing("one-white");
        } else if (this.stage === 2) {
            this.stageText.setDrawing("three-white");
        } else {
            this.stageText.visible = false;
        }

        this.add(new Timer(() => {
            this.getReady.setDrawing("glow");
            if (this.stage === 1) {
                this.stageText.setDrawing("one-glow");
            } else if (this.stage === 2) {
                this.stageText.setDrawing("three-glow");
            }
        }, 2 * 1000 / 60));

        this.add(new Timer(() => {
            this.getReady.setDrawing("fail");
            if (this.stage === 1) {
                this.stageText.setDrawing("one-fail");
            } else if (this.stage === 2) {
                this.stageText.setDrawing("three-fail");
            }
        }, 180 * 1000 / 60));
    }

    public onDeactivate(): void {
        resources.getReadyMusic.stop();
    }
}