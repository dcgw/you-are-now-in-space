import {Actor, Engine, Sound, Vector} from "excalibur";
import Game from "../game";
import Player from "../player/player";
import resources from "../resources";
import Alien, {AlienColour, height as alienHeight, width as alienWidth} from "./alien";
import AlienBullet from "./alien-bullet";
import {BrokenFormationBehaviour} from "./behaviours";

const colours: ReadonlyArray<AlienColour> = ["red", "brown", "grey", "green"];

const columns = 8;

const leftMargin = 22;
const bottomMargin = 11;
const separationX = 36;
const separationY = 24;
const offsetY = -2;
const breakawayMargin = 60 + offsetY;
const moveAmount = 6;
const shootInterval = 180 / 60 * 1000;
const bulletMinSpeed = 2 * 60;
const bulletSpeedIncrement = 0.5 * 60;

export default class Formation extends Actor {
    private moveTimer = 0;
    private moveInterval = 0;

    private shootTimer = 0;

    private readonly aliens: Alien[] = [];

    private readonly soundController = new SoundController();

    private topMost = 0;

    private directionLeft = true;
    private moveVertically = false;
    private breakaway = false;

    constructor(private game: Game, private player: Player) {
        super();

        for (let i = 0; i < colours.length; ++i) {
            const colour = colours[i];
            for (let j = 0; j < columns; ++j) {
                const alien = new Alien(game, colour);
                this.aliens.push(alien);
            }
        }
    }

    public reset(): void {
        this.moveTimer = 0;
        this.moveInterval = 32 / 60 * 1000;
        this.shootTimer = shootInterval / this.game.stage;
        this.topMost = 0;
        this.directionLeft = true;
        this.moveVertically = false;
        this.breakaway = false;

        this.scene.removeGroup("formation");
        const group = this.scene.createGroup("formation");

        for (let i = 0; i < colours.length; ++i) {
            for (let j = 0; j < columns; ++j) {
                const alien = this.aliens[i * columns + j];
                alien.reset();
                alien.x = this.game.playLeft + j * separationX + leftMargin;
                alien.y = this.game.playTop + this.game.playHeight - alienHeight
                    - bottomMargin - i * separationY + offsetY;
                group.add(alien);
            }
        }
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        let leftMost = this.game.playLeft + this.game.playWidth;
        let rightMost = this.game.playLeft;
        this.topMost = this.game.playTop + this.game.playHeight;
        let formationSize = 0;
        let nonBrokenFormationSize = 0;

        for (const alien of this.aliens) {
            if (!alien.isKilled()) {
                ++formationSize;

                // If they're in formation
                if (!alien.behaviour) {
                    ++nonBrokenFormationSize;

                    if (alien.x < leftMost) {
                        leftMost = alien.x;
                    }

                    if (alien.x > rightMost) {
                        rightMost = alien.x;
                    }

                    if (alien.y < this.topMost) {
                        this.topMost = alien.y;
                    }
                }
            }
        }

        if (formationSize === 0) {
            this.kill();
            return;
        }

        this.moveTimer += delta;
        if (this.moveTimer >= this.moveInterval) {
            this.moveTimer -= this.moveInterval;

            this.moveInterval = (formationSize - (this.game.stage - 1) * 4) / 60 * 1000;

            const formationWidth = rightMost + alienWidth - leftMost;

            this.soundController.play();

            if (leftMost <= this.game.playLeft
                || leftMost >= this.game.playLeft + this.game.playWidth - formationWidth
            ) {
                if (this.moveVertically) {
                    this.moveVertically = false;
                } else {
                    this.directionLeft = !this.directionLeft;
                    this.moveVertically = true;
                }
            }

            let moveX = 0;
            let moveY = 0;

            if (this.moveVertically) {
                if (this.player.y < this.topMost) {
                    moveY = -moveAmount;
                } else {
                    moveY = moveAmount;
                }
            } else {
                moveX = this.directionLeft
                    ? -moveAmount
                    : moveAmount;
            }

            for (const alien of this.aliens) {
                if (!alien.isKilled() && !alien.behaviour) {
                    alien.x += moveX;
                    alien.y += moveY;
                }
            }

            if (this.topMost <= this.game.playTop + breakawayMargin) {
                this.breakaway = true;
            }
        }

        this.shootTimer -= delta;
        const shooting = this.shootTimer <= 0;
        if (shooting) {
            this.shootTimer += shootInterval / this.game.stage;
        }

        if ((this.breakaway || shooting) && nonBrokenFormationSize > 0) {
            const selected = Math.floor(Math.random() * nonBrokenFormationSize);

            let i = 0;
            for (const alien of this.aliens) {
                if (!alien.isKilled() && !alien.behaviour) {
                    if (i === selected) {
                        if (this.breakaway) {
                            alien.behaviour = new BrokenFormationBehaviour(this.game, alien);
                        } else if (shooting) {
                            if (this.game.stage >= 5 && (
                                this.player.x > this.game.playLeft + this.game.playWidth
                                || this.player.x - this.player.getWidth() < this.game.playLeft
                            )) {
                                this.shootTowardsPlayer(alien);
                            } else {
                                this.shootVertically(alien);
                            }
                        }
                        break;
                    }
                    ++i;
                }
            }
        }

        if (this.breakaway && shooting && this.game.stage >= 5) {
            const selected = Math.floor(Math.random() * formationSize);

            let i = 0;
            for (const alien of this.aliens) {
                if (!alien.isKilled()) {
                    if (i === selected) {
                        this.shootTowardsPlayer(alien);
                        break;
                    }
                    ++i;
                }
            }
        }
    }

    private shootTowardsPlayer(alien: Alien): void {
        const direction = this.player.getCenter().sub(alien.getCenter()).normalize();
        this.shoot(alien, direction.scale(this.game.stage));
    }

    private shootVertically(alien: Alien): void {
        const direction = this.player.y < this.topMost
            ? Vector.Up
            : Vector.Down;
        this.shoot(alien, direction.scale(bulletMinSpeed + bulletSpeedIncrement * (this.game.stage - 1)));
    }

    private shoot(alien: Alien, velocity: Vector): void {
        resources.alienShot.play()
            .then(undefined, reason => console.error("", reason));
        this.game.engine.currentScene.add(new AlienBullet(this.game, alien.getCenter(), velocity));
    }
}

class SoundController {
    private readonly sounds: ReadonlyArray<Sound> = [
        resources.move1,
        resources.move2,
        resources.move3,
        resources.move4
    ];

    private position = 0;

    public play(): void {
        this.sounds[this.position].play()
            .then(undefined, reason => console.error("", reason));
        this.position = (this.position + 1) % this.sounds.length;
    }
}