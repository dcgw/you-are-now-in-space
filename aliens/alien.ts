import {Actor, CollisionType, Engine, SpriteSheet, Vector, Animation} from "excalibur";
import Game from "../game";
import Bullet from "../player/bullet";
import resources from "../resources";
import {Behaviour} from "./behaviours";

export const width = 24;
export const height = 17;

const spriteWidth = width;
const spriteHeight = 21;

const spriteSheet = new SpriteSheet({
    image: resources.alien,
    spWidth: spriteWidth,
    spHeight: spriteHeight,
    rows: 5,
    columns: 7
});

const anchor = Vector.Zero;

export type AlienColour = "red" | "green" | "brown" | "grey";

export default class Alien extends Actor {
    public behaviour: Behaviour | null = null;
    private readonly explodingAnimation: Animation;

    constructor(game: Game, private readonly colour: AlienColour) {
        super({width, height, anchor});

        this.addDrawing("red", spriteSheet.getAnimationBetween(game.engine, 0, 5, 4 * 1000 / 60));
        this.addDrawing("green", spriteSheet.getAnimationBetween(game.engine, 7, 12, 4 * 1000 / 60));
        this.addDrawing("brown", spriteSheet.getAnimationBetween(game.engine,
            14, 19, 4 * 1000 / 60));
        this.addDrawing("grey", spriteSheet.getAnimationBetween(game.engine, 21, 26, 4 * 1000 / 60));

        this.explodingAnimation = spriteSheet.getAnimationBetween(game.engine, 28, 34, 4 * 1000 / 60);
        this.explodingAnimation.loop = false;
        this.addDrawing("asplode", this.explodingAnimation);

        this.collisionType = CollisionType.Fixed;
    }

    public reset(): void {
        this.unkill();
        this.setDrawing(this.colour);
        this.explodingAnimation.reset();
        this.behaviour = null;
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        if (this.behaviour != null) {
            this.behaviour.update(delta);
        }

        const collider = this.scene.actors
            .find(a => a instanceof Bullet
                && a.collides(this));

        if (collider) {
            this.setDrawing("asplode");
            this.scene.remove(collider);
        }

        if (this.explodingAnimation.isDone()) {
            this.kill();
        }
    }
}