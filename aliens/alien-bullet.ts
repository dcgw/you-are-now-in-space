import {Actor, CollisionType, Engine, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

const width = 5;
const height = 5;

const anchor = new Vector(0.5, 0.5);

export default class AlienBullet extends Actor {
    constructor(private game: Game, position: Vector, velocity: Vector) {
        super({
            pos: position,
            width,
            height,
            anchor,
            vel: velocity,
        });
        this.addDrawing(resources.alienBullet);
        this.body.collider.group = game.collisionGroups.aliens;
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