import {Input} from "excalibur";
import Game from "../game";
import Alien, {height, width} from "./alien";

export interface Behaviour {
    update(delta: number): void;
}

const speed = 60 / 1000;

export class BrokenFormationBehaviour implements Behaviour {
    private layer = Math.random() * 3 + 2;

    constructor(private readonly game: Game, private readonly alien: Alien) {
    }

    public update(delta: number): void {
        this.alien.pos.y -= speed * this.layer * delta;

        if (this.game.engine.input.keyboard.isHeld(Input.Keys.Left)) {
            this.alien.pos.x -= speed * this.layer * delta;
        }

        if (this.game.engine.input.keyboard.isHeld(Input.Keys.Right)) {
            this.alien.pos.x += speed * this.layer * delta;
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