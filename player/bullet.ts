import {Actor, CollisionType, Vector} from "excalibur";
import resources from "../resources";

const width = 5;
const height = 10;

const speed = 10 * 60;

export default class Bullet extends Actor {
    constructor(x: number, y: number) {
        super({x, y, width, height, vel: new Vector(0, speed)});
        this.addDrawing(resources.bullet);
        this.collisionType = CollisionType.Fixed;
    }
}