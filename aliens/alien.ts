import {Actor, CollisionType, Engine, SpriteSheet, Vector} from "excalibur";
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
    rows: 4,
    columns: 7
});

const anchor = new Vector(0, 2);

export type AlienColour = "red" | "green" | "brown" | "grey";

export default class Alien extends Actor {
    public behaviour: Behaviour | null = null;

    constructor(game: Game, colour: AlienColour) {
        super({width, height, anchor});

        this.addDrawing("red", spriteSheet.getAnimationBetween(game.engine, 0, 5, 4 * 1000 / 60));
        this.addDrawing("green", spriteSheet.getAnimationBetween(game.engine, 7, 12, 4 * 1000 / 60));
        this.addDrawing("brown", spriteSheet.getAnimationBetween(game.engine,
            14, 19, 4 * 1000 / 60));
        this.addDrawing("grey", spriteSheet.getAnimationBetween(game.engine, 21, 26, 4 * 1000 / 60));
        this.addDrawing("asplode", spriteSheet.getAnimationBetween(game.engine, 28, 34, 4 * 1000 / 60));

        this.setDrawing(colour);
        this.collisionType = CollisionType.Fixed;
    }

    public reset(): void {
        this.behaviour = null;
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        if (this.behaviour != null) {
            this.behaviour.update(delta);
        }
        const collidingActors = this.scene.actors.filter(a => a instanceof Bullet && a.collides(this));
        if (collidingActors.length > 0) {
            this.scene.remove(this);
            collidingActors.forEach(a => this.scene.remove(a));
        }
    }
}