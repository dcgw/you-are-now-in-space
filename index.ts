import domready = require("domready");
import {DisplayMode, Engine, Loader} from "excalibur";
import Player from "./actors/player/player";
import resources from "./resources";
import LevelOne from "./scenes/level-one/level-one";

class Game extends Engine {
    constructor() {
        super({width: 800, height: 600, displayMode: DisplayMode.FullScreen});
    }
}

domready(() => {
    const game = new Game();
    const levelOne = new LevelOne(game);
    const player = new Player();
    player.addDrawing(resources.Sword);

    levelOne.add(player);

    game.add("levelOne", levelOne);


    const loader = new Loader();
    for (const key of Object.keys(resources)) {
        loader.addResource(resources[key]);
    }

    game.start(loader)
        .then(() => game.goToScene("levelOne"))
        .error(reason => console.error("", reason));
});