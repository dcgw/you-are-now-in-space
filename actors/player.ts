import {Actor, SpriteSheet} from "excalibur";
import Game from "../game";
import resources from "../resources";

const width = 21;
const height = 24;

const spriteSheet = new SpriteSheet({
    image: resources.player,
    spWidth: width,
    spHeight: height,
    rows: 1,
    columns: 7
});

export default class Player extends Actor {
    constructor(game: Game) {
        super({
            x: (game.width - width) * 0.5,
            y: game.playTop,
            width,
            height
        });

        this.addDrawing("spinning", spriteSheet.getAnimationForAll(game.engine, 4 * 1000 / 60));
    }
}