import {Actor, SpriteSheet, Vector} from "excalibur";
import Game from "../game";
import resources from "../resources";

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

export default class Alien extends Actor {
    constructor(game: Game, colour: "red" | "green" | "brown" | "grey") {
        super({width, height, anchor});

        this.addDrawing("red", spriteSheet.getAnimationBetween(game.engine, 0, 5, 4 * 1000 / 60));
        this.addDrawing("green", spriteSheet.getAnimationBetween(game.engine, 7, 12, 4 * 1000 / 60));
        this.addDrawing("brown", spriteSheet.getAnimationBetween(game.engine,
            14, 19, 4 * 1000 / 60));
        this.addDrawing("grey", spriteSheet.getAnimationBetween(game.engine, 21, 26, 4 * 1000 / 60));
        this.addDrawing("asplode", spriteSheet.getAnimationBetween(game.engine, 28, 33, 4 * 1000 / 60));

        this.setDrawing(colour);
    }
}