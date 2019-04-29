import {Input} from "excalibur";
import Game from "../game";
import Alien, {height, width} from "./alien";

export interface Behaviour {
    update(delta: number): void;
}

const speed = 1 / 60 * 1000;

export class BrokenFormationBehaviour implements Behaviour {
    private layer = Math.random() * 3 + 2;

    constructor(private readonly game: Game, private readonly alien: Alien) {
    }

    public update(delta: number): void {
        this.alien.y -= speed * this.layer;

        if (this.game.engine.input.keyboard.isHeld(Input.Keys.Left)) {
            this.alien.x -= speed * this.layer;
        }

        if (this.game.engine.input.keyboard.isHeld(Input.Keys.Right)) {
            this.alien.x += speed * this.layer;
        }

        if (this.alien.y <= -height) {
            this.alien.y += this.game.height;
        }

        if (this.alien.x <= -width) {
            this.alien.x += this.game.width;
        }

        if (this.alien.x >= this.game.width) {
            this.alien.x -= this.game.width;
        }
    }
}