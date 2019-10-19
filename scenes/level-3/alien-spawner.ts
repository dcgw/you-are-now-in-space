import {Actor, Engine} from "excalibur";
import Alien, {colours} from "../../aliens/alien";
import {Level3Behaviour} from "../../aliens/behaviours";
import Game from "../../game";

const spawnInterval = 160 * 1000 / 60;

export default class AlienSpawner extends Actor {
    private time = 0;

    constructor(private readonly game: Game) {
        super();
    }

    public reset(): void {
        this.time = 0;
    }

    public update(engine: Engine, delta: number): void {
        this.time += delta * this.game.stage;
        if (this.time >= spawnInterval) {
            this.spawnAlien();
        }
    }

    private spawnAlien(): void {
        const colour = colours[Math.floor(Math.random() * colours.length)];
        const alien = new Alien(this.game, colour);
        alien.behaviour = new Level3Behaviour(this.game, alien);
        this.scene.add(alien);

        alien.on("asplode", () => this.game.score += 100 * this.game.stage);

        this.time -= spawnInterval;
    }
}