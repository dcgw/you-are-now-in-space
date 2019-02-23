import domready = require("domready");
import {DisplayMode, Engine, Loader} from "excalibur";
import Player from "./actors/player/player";
import resources from "./resources";
import LevelOne from "./scenes/level-one/level-one";

domready(() => {
    const engine = new Engine({
        width: 384,
        height: 288,
        displayMode: DisplayMode.FullScreen
    });
    const levelOne = new LevelOne(engine);
    const player = new Player();
    player.addDrawing(resources.Sword);

    levelOne.add(player);

    engine.add("levelOne", levelOne);


    const loader = new Loader();
    for (const key of Object.keys(resources)) {
        loader.addResource(resources[key]);
    }

    engine.start(loader)
        .then(() => engine.goToScene("levelOne"),
            reason => console.error("", reason));
});