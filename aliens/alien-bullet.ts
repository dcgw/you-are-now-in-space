import {Actor, Engine, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

const width = 5;
const height = 5;

export default class AlienBullet extends Actor {
    constructor(private game: Game, x: number, y: number, vx: number, vy: number) {
        super({x, y, width, height, vel: new Vector(vx, vy)});
        this.addDrawing(resources.alienBullet);
    }


    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        if (this.x < 0 || this.x > this.game.width || this.y < 0 || this.y > this.game.height) {
            this.scene.remove(this);
        }
    }
}