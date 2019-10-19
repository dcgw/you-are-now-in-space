import {Actor, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

export default class KevinToms extends Actor {
    constructor(game: Game) {
        super({
            pos: new Vector(game.playLeft + 32, game.playTop + 56),
            anchor: Vector.Zero
        });
        this.addDrawing(resources.kevinToms);
    }

    public onInitialize(): void {
        this.z = 2;
    }
}