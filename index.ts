import {Dictionary} from "dictionary-types";
import {DisplayMode, Engine, Loader, Sound, Texture} from "excalibur";
import resources from "./resources";
import Title from "./scenes/title";
import domready = require("domready");

domready(() => {
    const engine = new Engine({
        width: 384,
        height: 288,
        displayMode: DisplayMode.FullScreen
    });

    const loader = new Loader();
    for (const key of Object.keys(resources)) {
        loader.addResource((resources as Dictionary<Texture | Sound>)[key]);
    }

    engine.start(loader)
        .then(() => {
                engine.add("title", new Title(engine));
                engine.goToScene("title");
            },
            reason => console.error("", reason));
});