import {Actor, Scene, SpriteSheet, Timer, Vector} from "excalibur";
import Game from "../../game";
import resources from "../../resources";

const spriteSheetWidth = 128;
const spriteSheetHeight = 8;

const spriteSheet = new SpriteSheet({
    image: resources.intermission,
    spWidth: spriteSheetWidth,
    spHeight: spriteSheetHeight,
    rows: 8,
    columns: 1
});

export default class Intermission extends Scene {
    private readonly message = new Actor({
        pos: new Vector((this.game.width - this.game.playWidth) * .5 + 96,
            (this.game.height - this.game.playHeight) * .5 + 64),
        width: spriteSheetWidth,
        height: spriteSheetHeight,
        anchor: Vector.Zero
    });

    private readonly failTimer = new Timer({
        fcn: () => {
            this.message.setDrawing(this.game.lives + "fail");
        },
        interval: 180 * 1000 / 60
    });

    constructor(private readonly game: Game) {
        super(game.engine);

        this.message.addDrawing("3", spriteSheet.getSprite(0));
        this.message.addDrawing("2", spriteSheet.getSprite(1));
        this.message.addDrawing("1", spriteSheet.getSprite(2));
        this.message.addDrawing("0", spriteSheet.getSprite(3));
        this.message.addDrawing("3fail", spriteSheet.getSprite(4));
        this.message.addDrawing("2fail", spriteSheet.getSprite(5));
        this.message.addDrawing("1fail", spriteSheet.getSprite(6));
        this.message.addDrawing("0fail", spriteSheet.getSprite(7));
        this.add(this.message);

        this.add(this.failTimer);
    }

    public onActivate(): void {
        resources.intermissionMusic.play()
            .then(
                () => {
                    if (this.game.lives > 0) {
                        if (this.game.stage & 1) {
                            this.game.engine.goToScene("level-1");
                        } else {
                            this.game.engine.goToScene("level-3");
                        }
                    } else {
                        this.game.engine.goToScene("title");
                    }
                },
                reason => console.error("", reason));

        this.message.setDrawing(this.game.lives);

        this.failTimer.reset();
    }

    public onDeactivate(): void {
        resources.intermissionMusic.stop();
    }
}