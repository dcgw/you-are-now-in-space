import {Dictionary} from "dictionary-types";
import {
    CollisionGroupManager,
    CollisionResolutionStrategy,
    DisplayMode,
    Engine,
    Loader,
    Physics,
    Sound,
    Texture
} from "excalibur";
import resources from "./resources";
import GetReady from "./scenes/get-ready/get-ready";
import Intermission from "./scenes/intermission/intermission";
import Level1 from "./scenes/level-1/level-1";
import Level3 from "./scenes/level-3/level-3";
import Title from "./scenes/title/title";

export default class Game {
    public readonly width = 384;
    public readonly height = 288;

    public readonly playWidth = 320;
    public readonly playHeight = 200;

    public readonly playLeft = (this.width - this.playWidth) * 0.5;
    public readonly playTop = (this.height - this.playHeight) * 0.5;

    public readonly collisionGroups = {
        player: CollisionGroupManager.create("player"),
        aliens: CollisionGroupManager.create("aliens")
    };

    public active = false;
    public lives = 4;
    public stage = 1;
    public score = 0;

    private pointerTimeout = 0;

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
        window.addEventListener("mousemove", this.onMouseMove);
        window.addEventListener("blur", this.onBlur);

        Physics.collisionResolutionStrategy = CollisionResolutionStrategy.Box;

        this.reset();

        this.engine.start(loader)
            .then(() => {
                this.engine.add("title", new Title(this));
                this.engine.add("get-ready", new GetReady(this));
                this.engine.add("intermission", new Intermission(this));
                this.engine.add("level-1", new Level1(this));
                this.engine.add("level-3", new Level3(this));
                this.engine.goToScene("title");
            }, reason => console.error("", reason));
    }

    public reset(): void {
        this.lives = 4;
        this.stage = 1;
        this.score = 0;
    }

    private hidePointer(): void {
        this.engine.canvas.style.cursor = "none";
    }

    private showPointer(): void {
        this.engine.canvas.style.cursor = "auto";
    }

    private readonly onClick = () => {
        this.hidePointer();
        this.active = true;
    }

    private readonly onBlur = () => {
        this.showPointer();
        this.active = false;
    }

    private readonly onMouseMove = () => {
        this.showPointer();

        if (this.pointerTimeout) {
            clearTimeout(this.pointerTimeout);
        }

        this.pointerTimeout = setTimeout(() => {
            if (this.active) {
                this.hidePointer();
            }
        }, 500);
    }
}