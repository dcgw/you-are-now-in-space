import {Actor, SpriteSheet, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

const width = 384;
const height = 288;

const spriteSheet = new SpriteSheet({
    image: resources.border,
    spWidth: width,
    spHeight: height,
    rows: 7,
    columns: 1
});

export default class Border extends Actor {
    constructor(game: Game) {
        super({
            x: 0,
            y: 0,
            width,
            height,
            anchor: Vector.Zero
        });

        this.addDrawing("black", spriteSheet.sprites[0]);
        this.addDrawing("alert", spriteSheet.getAnimationByIndices(game.engine,
            [0, 1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1],
            4 * 1000 / 60));
    }

    public enableAlert(): void {
        this.setDrawing("alert");
    }

    public disableAlert(): void {
        this.setDrawing("black");
    }
}