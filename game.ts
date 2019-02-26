import {Dictionary} from "dictionary-types";
import {DisplayMode, Engine, Loader, Sound, Texture} from "excalibur";
import resources from "./resources";
import GetReady from "./scenes/get-ready";
import Level1 from "./scenes/level-1";
import Title from "./scenes/title";

export default class Game {
    public readonly width = 384;
    public readonly height = 288;

    public readonly playWidth = 320;
    public readonly playHeight = 200;

    public active = false;
    public stage = 1;
    public score = 0;

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

        this.engine.input.pointers.primary.on("up", this.onClick);
        this.engine.input.keyboard.on("press", this.onClick);
        window.addEventListener("blur", this.onBlur);

        this.reset();

        this.engine.start(loader)
            .then(() => {
                this.engine.add("title", new Title(this));
                this.engine.add("get-ready", new GetReady(this));
                this.engine.add("level-1", new Level1(this));
                this.engine.goToScene("title");
            }, reason => console.error("", reason));
    }

    public reset(): void {
        this.stage = 1;
        this.score = 0;
    }

    private readonly onClick = () => this.active = true;

    private readonly onBlur = () => this.active = false;
}