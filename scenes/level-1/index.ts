import {Color, Engine, Scene} from "excalibur";
import Formation from "../../aliens/formation";
import Game from "../../game";
import Border from "../../hud/border";
import Score from "../../hud/score";
import Player from "../../player/player";
import resources from "../../resources";

export default class Level1 extends Scene {
    private readonly border = new Border(this.game);
    private readonly player: Player;
    private readonly formation: Formation;

    private scoreTime = 0;
    private handledBreakaway = false;

    constructor(private readonly game: Game) {
        super(game.engine);

        this.player = new Player(game);
        this.player.on("kill", () => this.killed());

        this.add(new Score(game));
        this.add(this.border);

        this.formation = new Formation(game, this.player);
        this.add(this.formation);
    }

    public onActivate(): void {
        this.border.disableAlert();
        this.add(this.player);
        this.player.reset();
        this.game.engine.backgroundColor = Color.fromHex("000000");
        this.formation.reset();
        this.scoreTime = 1200 * 1000 / 60;
        this.handledBreakaway = false;
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        this.scoreTime -= delta;

        if (this.scoreTime <= 0) {
            this.complete();
        }

        if (this.formation.isBreakaway() && !this.handledBreakaway) {
            this.handledBreakaway = true;
            resources.alert.loop = true;
            resources.alert.play()
                .then(() => void 0,
                    reason => console.error("", reason));
            this.border.enableAlert();
        }
    }

    private killed(): void {
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