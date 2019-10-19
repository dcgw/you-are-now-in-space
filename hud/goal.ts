import {Actor, SpriteSheet, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

const charWidth = 16;
const charHeight = 16;

const spriteSheet = new SpriteSheet({
    image: resources.score,
    spWidth: charWidth,
    spHeight: charHeight,
    rows: 1,
    columns: 10
});

export default class Goal extends Actor {
    public bonus = 0;

    constructor(game: Game) {
        super({
            x: game.playLeft + 80,
            y: game.playTop + 32,
            anchor: Vector.Zero
        });
        this.addDrawing(resources.goal);
    }

    public onInitialize(): void {
        this.z = 2;
    }

    public draw(context: CanvasRenderingContext2D, delta: number): void {
        super.draw(context, delta);

        this.bonus.toFixed(0)
            .split("")
            .map(n => parseInt(n, 10))
            .forEach((n, i) => {
                spriteSheet.getSprite(n)
                    .draw(context, this.pos.x + (6 + i) * charWidth, this.pos.y);
            });
    }
}