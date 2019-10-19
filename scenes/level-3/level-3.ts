import {Engine, Scene} from "excalibur";
import Alien from "../../aliens/alien";
import Game from "../../game";
import Border from "../../hud/border";
import Score from "../../hud/score";
import Bullet from "../../player/bullet";
import Player from "../../player/player";
import resources from "../../resources";
import AlienSpawner from "./alien-spawner";

export default class Level3 extends Scene {
    private readonly border = new Border(this.game);
    private readonly player = new Player(this.game);
    private readonly alienSpawner = new AlienSpawner(this.game);

    private time = 0;

    constructor(private readonly game: Game) {
        super(game.engine);
        this.add(new Score(game));
        this.add(this.border);
        this.add(this.alienSpawner);

        this.player.on("kill", () => this.killed());
    }

    public onActivate(): void {
        this.border.enableAlert();
        this.player.reset();
        this.add(this.player);
        this.alienSpawner.reset();

        [...this.actors].forEach(actor => {
            if (actor instanceof Alien || actor instanceof Bullet) {
                actor.kill();
            }
        });

        resources.alert.loop = true;
        resources.alert.play()
            .then(() => void 0, reason => console.error("", reason));

        this.time = 120 * this.game.stage * 1000 / 60;
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        this.time -= delta;
        if (this.time <= 0) {
            this.complete();
        }
    }

    private killed(): void {
        --this.game.lives;
        this.end("intermission");
    }

    private complete(): void {
        ++this.game.stage;
        this.end("get-ready");
    }

    private end(scene: string): void {
        resources.alert.stop();
        this.game.engine.goToScene(scene);
    }
}