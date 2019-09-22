import {Actor, Engine, Vector, CollisionType} from "excalibur";
import Game from "../game";
import resources from "../resources";

const width = 5;
const height = 5;

const anchor = new Vector(0.5, 0.5);

export default class AlienBullet extends Actor {
    constructor(private game: Game, position: Vector, velocity: Vector) {
        super({
            x: position.x,
            y: position.y,
            width,
            height,
            anchor,
            vel: velocity,
        });
        this.addDrawing(resources.alienBullet);
        this.addCollisionGroup("aliens");
        this.collisionType = CollisionType.Active;
    }


    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        if (this.x < 0 || this.x > this.game.width || this.y < 0 || this.y > this.game.height) {
            this.scene.remove(this);
        }
    }
}