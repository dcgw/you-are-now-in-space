import {Actor, Engine} from "excalibur";
import resources from "../resources";

const width = 5;
const height = 10;

const speed = 10 * 60 / 1000;

export default class Bullet extends Actor {
    constructor(x: number, y: number) {
        super({x, y, width, height});
        this.addDrawing(resources.bullet);
    }

    public update(engine: Engine, delta: number): void {
        this.y += speed * delta;
    }
}