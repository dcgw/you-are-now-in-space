import {Input} from "excalibur";
import Game from "../game";
import Alien, {height, width} from "./alien";

export interface Behaviour {
    update(delta: number): void;
}

const brokenFormationSpeed = 60 / 1000;

export class BrokenFormationBehaviour implements Behaviour {
    private layer = Math.random() * 3 + 2;

    constructor(private readonly game: Game, private readonly alien: Alien) {
    }

    public update(delta: number): void {
        this.alien.pos.y -= brokenFormationSpeed * this.layer * delta;

        if (this.game.engine.input.keyboard.isHeld(Input.Keys.Left)) {
            this.alien.pos.x -= brokenFormationSpeed * this.layer * delta;
        }

        if (this.game.engine.input.keyboard.isHeld(Input.Keys.Right)) {
            this.alien.pos.x += brokenFormationSpeed * this.layer * delta;
        }

        if (this.alien.pos.y <= -height) {
            this.alien.pos.y += this.game.height;
        }

        if (this.alien.pos.x <= -width) {
            this.alien.pos.x += this.game.width;
        }

        if (this.alien.pos.x >= this.game.width) {
            this.alien.pos.x -= this.game.width;
        }
    }
}

const level3Speed = 0.2 * 60 / 1000;

export class Level3Behaviour implements Behaviour {
    private pos = Math.random() * Math.PI * 2;

    private pathLeft = Math.random() * this.game.playWidth / 2 + this.game.playWidth / 4;
    private pathTop = Math.random() * this.game.playHeight / 2 + this.game.playHeight / 4;
    private pathWidth = Math.random() * this.pathLeft - this.game.playWidth / 4;
    private pathHeight = Math.random() * this.pathTop - this.game.playHeight / 4;

    constructor(private readonly game: Game, private readonly alien: Alien) {
    }

    public update(delta: number): void {
        this.pos += level3Speed * this.game.stage;
        this.alien.pos.x = this.game.playLeft + this.pathLeft + this.pathWidth * Math.cos(this.pos);
        this.alien.pos.y = this.game.playTop + this.pathTop + this.pathHeight * math.sin(pos);
    }
}