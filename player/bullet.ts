import {Actor, CollisionType, Engine, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

const width = 5;
const height = 10;

const speed = 10 * 60;

export default class Bullet extends Actor {
    constructor(private readonly game: Game, position: Vector) {
        super({pos: position, width, height, vel: new Vector(0, speed)});
        this.addDrawing(resources.bullet);
        this.body.collider.group = game.collisionGroups.player;
        this.body.collider.type = CollisionType.Passive;
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        if (
            this.pos.x < 0
            || this.pos.x > this.game.width
            || this.pos.y < 0
            || this.pos.y > this.game.height
        ) {
            this.kill();
        }
    }
}