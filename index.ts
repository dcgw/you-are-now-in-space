import domready = require("domready");
import * as ex from "excalibur";
import Player from "./actors/player/player";
import resources from "./resources";
import LevelOne from "./scenes/level-one/level-one";

class Game extends ex.Engine {
    constructor() {
        super({width: 800, height: 600, displayMode: ex.DisplayMode.FullScreen});
    }
}

domready(() => {
    const game = new Game();
    const levelOne = new LevelOne(game);
    const player = new Player();
    player.addDrawing(resources.Sword);

    levelOne.add(player);

    game.add("levelOne", levelOne);


    const loader = new ex.Loader();
    for (const key of Object.keys(resources)) {
        loader.addResource(resources[key]);
    }

    game.start(loader)
        .then(() => game.goToScene("levelOne"))
        .error(reason => console.error("", reason)); // tslint:disable-line:
});