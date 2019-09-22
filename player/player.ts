import {Actor, Animation, Engine, Input, SpriteSheet, Vector} from "excalibur";
import AlienBullet from "../aliens/alien-bullet";
import Game from "../game";
import resources from "../resources";
import Bullet from "./bullet";

const width = 21;
const height = 24;

const speed = 5 * 60 / 1000;
const shotInterval = 24 / 60 * 1000;

const spriteSheet = new SpriteSheet({
    image: resources.player,
    spWidth: width,
    spHeight: height,
    rows: 1,
    columns: 7
});

const asplodeSpriteSheet = new SpriteSheet({
    image: resources.alien,
    spWidth: width,
    spHeight: height,
    rows: 5,
    columns: 7
});

export default class Player extends Actor {
    private fixedX = false;
    private shotCoolDown = 0;
    private readonly explodingAnimation: Animation;

    constructor(private game: Game) {
        super({
            pos: new Vector((game.width - width) * 0.5, game.playTop),
            width,
            height,
            anchor: Vector.Zero
        });

        this.addDrawing("spinning", spriteSheet.getAnimationForAll(game.engine, 4 * 1000 / 60));
        this.explodingAnimation = asplodeSpriteSheet.getAnimationBetween(game.engine, 28, 34, 4 * 1000 / 60);
        this.explodingAnimation.loop = false;
        this.addDrawing("asploding", this.explodingAnimation);
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        if (engine.input.keyboard.isHeld(Input.Keys.X) && this.shotCoolDown <= 0) {
            this.scene.add(new Bullet(this.pos.add(new Vector(width * 0.5, height * 0.5))));
            resources.laser.play()
                .then(undefined, reason => console.error("", reason));
            this.shotCoolDown = shotInterval;
        } else {
            this.shotCoolDown -= delta;
        }

        if (engine.input.keyboard.isHeld(Input.Keys.Left) && !this.fixedX) {
            this.pos.x -= speed * delta;
        }

        if (engine.input.keyboard.isHeld(Input.Keys.Right) && !this.fixedX) {
            this.pos.x += speed * delta;
        }

        if (engine.input.keyboard.isHeld(Input.Keys.Up)) {
            this.pos.y -= speed * delta;
        }

        if (engine.input.keyboard.isHeld(Input.Keys.Down)) {
            this.pos.y += speed * delta;
        }

        if (this.pos.x < 0) {
            this.pos.x = 0;
        }

        if (this.pos.x + width > this.game.width) {
            this.pos.x = this.game.width - width;
        }

        if (this.pos.y < 0) {
            this.pos.y = 0;
        }

        if (this.pos.y + height > this.game.height) {
            this.pos.y = this.game.height - height;
        }

        const collider = this.scene.actors
            .find(a => a instanceof AlienBullet
                && a.collides(this));

        if (collider) {
            this.setDrawing("asploding");
            this.scene.remove(collider);
        }

        if (this.explodingAnimation.isDone()) {
            this.kill();
        }
    }
}