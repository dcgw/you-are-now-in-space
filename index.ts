import {Dictionary} from "dictionary-types";
import domready = require("domready");
import {DisplayMode, Engine, Loader, Sound, Texture} from "excalibur";
import resources from "./resources";
import GetReady from "./scenes/get-ready";
import Title from "./scenes/title";

export const WIDTH = 384;
export const HEIGHT = 288;

domready(() => {
    const engine = new Engine({
        width: WIDTH,
        height: HEIGHT,
        displayMode: DisplayMode.Fixed,
        suppressPlayButton: true
    });

    engine.canvas.style.position = "absolute";
    (engine.canvas.style as any).imageRendering = "pixelated";

    function scale(): void {
        const scaleFactor = Math.floor(Math.min(
            window.innerWidth / WIDTH,
            window.innerHeight / HEIGHT
        ));

        const scaledWidth = WIDTH * scaleFactor;
        const scaledHeight = HEIGHT * scaleFactor;

        engine.canvas.style.left = Math.floor((window.innerWidth - scaledWidth) * 0.5) + "px";
        engine.canvas.style.top = Math.floor((window.innerHeight - scaledHeight) * 0.5) + "px";
        engine.canvas.style.width = scaledWidth + "px";
        engine.canvas.style.height = scaledHeight + "px";
    }

    scale();

    window.addEventListener("resize", scale);

    const loader = new Loader();
    for (const key of Object.keys(resources)) {
        const resource = (resources as Dictionary<Texture | Sound>)[key];
        resource.bustCache = false;
        loader.addResource(resource);
    }

    engine.start(loader)
        .then(() => {
            engine.add("title", new Title(engine));
            engine.add("get-ready", new GetReady(engine, 1));
            engine.goToScene("title");
        }, reason => console.error("", reason));
});