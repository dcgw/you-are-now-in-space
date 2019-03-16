import {Actor, SpriteSheet, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

const width = 16;
const height = 16;

const spriteSheet = new SpriteSheet({
    image: resources.score,
    spWidth: width,
    spHeight: height,
    rows: 1,
    columns: 10
});

export default class Score extends Actor {
    constructor(private readonly game: Game) {
        super({
            x: (game.width - game.playWidth) * .5,
            y: (game.height - game.playHeight) * .5 + 200 + 10,
            width: game.playWidth,
            height,
            anchor: Vector.Zero
        });
    }

    public onInitialize(): void {
        this.z = 1;
    }

    public draw(context: CanvasRenderingContext2D): void {
        this.game.score.toFixed(0)
            .split("")
            .map(n => parseInt(n, 10))
            .forEach((n, i) => {
                spriteSheet.getSprite(n)
                    .draw(context, this.x + i * width, this.y);
            });
    }
}