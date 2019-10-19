import {Actor, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

export default class KevinToms extends Actor {
    constructor(game: Game) {
        super({
            x: game.playLeft + 32,
            y: game.playTop + 56,
            anchor: Vector.Zero
        });
        this.addDrawing(resources.kevinToms);
    }

    public onInitialize(): void {
        this.z = 2;
    }
}