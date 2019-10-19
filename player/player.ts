import {Actor, Animation, CollisionType, Engine, GameEvent, Input, SpriteSheet, Vector} from "excalibur";
import Alien from "../aliens/alien";
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
    spWidth: 24,
    spHeight: 21,
    rows: 5,
    columns: 7
});

export default class Player extends Actor {
    public fixedX = false;
    private dead = false;
    private shotCoolDown = 0;
    private readonly explodingAnimation: Animation;

    constructor(private game: Game) {
        super({
            width,
            height,
            anchor: Vector.Zero
        });

        this.addDrawing("spinning", spriteSheet.getAnimationForAll(game.engine, 4 * 1000 / 60));
        this.explodingAnimation = asplodeSpriteSheet.getAnimationBetween(game.engine, 28, 34, 4 * 1000 / 60);
        this.explodingAnimation.loop = false;
        this.addDrawing("asploding", this.explodingAnimation);

        this.body.collider.group = game.collisionGroups.player;
        this.body.collider.type = CollisionType.Passive;

        this.on("collisionstart", this.onCollisionStart);
    }

    public reset(): void {
        this.unkill();
        this.fixedX = false;
        this.dead = false;
        this.shotCoolDown = 0;
        this.explodingAnimation.reset();
        this.setDrawing("spinning");
        this.pos.x = (this.game.width - width) * 0.5;
        this.pos.y = this.game.playTop;
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        if (!this.dead) {
            if (engine.input.keyboard.isHeld(Input.Keys.X) && this.shotCoolDown <= 0) {
                this.scene.add(new Bullet(this.game, this.pos.add(new Vector(width * 0.5, height * 0.5))));
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

        if (this.explodingAnimation.isDone()) {
            this.kill();
        }
    }

    private onCollisionStart = (event: GameEvent<Actor>) => {
        if (this.dead) {
            return;
        } else if (event.other instanceof AlienBullet) {
            this.collideWithAlienBullet(event.other);
        } else if (event.other instanceof Alien) {
            this.asplode();
        }
    }

    private collideWithAlienBullet(bullet: AlienBullet): void {
        this.asplode();
        bullet.kill();
    }

    private asplode(): void {
        this.setDrawing("asploding");
        resources.playerSplode.play()
            .then(() => void 0, reason => console.error("", reason));
        this.dead = true;
    }
}