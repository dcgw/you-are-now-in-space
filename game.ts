import {Dictionary} from "dictionary-types";
import {DisplayMode, Engine, Loader, Sound, Texture} from "excalibur";
import resources from "./resources";
import GetReady from "./scenes/get-ready";
import Title from "./scenes/title";

export class Game {
    public readonly width = 384;
    public readonly height = 288;

    public readonly engine = new Engine({
        width: this.width,
        height: this.height,
        displayMode: DisplayMode.Fixed,
        suppressPlayButton: true
    });

    constructor() {
        this.engine.canvas.style.position = "absolute";
        (this.engine.canvas.style as any).imageRendering = "pixelated";
    }

    public start(): void {
        const loader = new Loader();
        for (const key of Object.keys(resources)) {
            const resource = (resources as Dictionary<Texture | Sound>)[key];
            resource.bustCache = false;
            loader.addResource(resource);
        }

        this.engine.start(loader)
            .then(() => {
                this.engine.add("title", new Title(this));
                this.engine.add("get-ready", new GetReady(this, 1));
                this.engine.goToScene("title");
            }, reason => console.error("", reason));
    }
}