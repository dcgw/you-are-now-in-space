import {Actor, Engine, Input, SpriteSheet, Vector} from "excalibur";
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
    rows: 4,
    columns: 7
});

export default class Player extends Actor {
    private fixedX = false;
    private shotCoolDown = 0;

    constructor(private game: Game) {
        super({
            x: (game.width - width) * 0.5,
            y: game.playTop,
            width,
            height,
            anchor: Vector.Zero
        });

        this.addDrawing("spinning", spriteSheet.getAnimationForAll(game.engine, 4 * 1000 / 60));
        this.addDrawing("asploding", asplodeSpriteSheet.getAnimationBetween(game.engine, 28, 34, 4 * 1000 / 60));
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        if (engine.input.keyboard.isHeld(Input.Keys.X) && this.shotCoolDown <= 0) {
            this.scene.add(new Bullet(this.x + width * 0.5, this.y + height * 0.5));
            resources.laser.play()
                .then(undefined, reason => console.error("", reason));
            this.shotCoolDown = shotInterval;
        } else {
            this.shotCoolDown -= delta;
        }

        if (engine.input.keyboard.isHeld(Input.Keys.Left) && !this.fixedX) {
            this.x -= speed * delta;
        }

        if (engine.input.keyboard.isHeld(Input.Keys.Right) && !this.fixedX) {
            this.x += speed * delta;
        }

        if (engine.input.keyboard.isHeld(Input.Keys.Up)) {
            this.y -= speed * delta;
        }

        if (engine.input.keyboard.isHeld(Input.Keys.Down)) {
            this.y += speed * delta;
        }

        if (this.x < 0) {
            this.x = 0;
        }

        if (this.x + width > this.game.width) {
            this.x = this.game.width - width;
        }

        if (this.y < 0) {
            this.y = 0;
        }

        if (this.y + height > this.game.height) {
            this.y = this.game.height - height;
        }
    }
}