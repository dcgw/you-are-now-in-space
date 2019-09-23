import {Color, Engine, Scene} from "excalibur";
import Formation from "../../aliens/formation";
import Game from "../../game";
import Border from "../../hud/border";
import Score from "../../hud/score";
import Player from "../../player/player";

export default class Level1 extends Scene {
    private readonly player: Player;
    private readonly formation: Formation;

    private scoreTime = 0;

    constructor(private readonly game: Game) {
        super(game.engine);

        this.player = new Player(game);

        this.add(new Score(game));
        this.add(new Border(game));

        this.formation = new Formation(game, this.player);
        this.add(this.formation);
    }

    public onActivate(): void {
        this.add(this.player);
        this.player.reset();
        this.game.engine.backgroundColor = Color.fromHex("000000");
        this.formation.reset();
        this.scoreTime = 1200 * 1000 / 60;
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        this.scoreTime -= delta;

        if (this.scoreTime <= 0) {
            this.finish();
        }
    }

    private finish(scene = "get-ready"): void {
        ++this.game.stage;
        this.game.engine.goToScene(scene);
    }
}