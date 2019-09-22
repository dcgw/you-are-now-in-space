import {Color, Engine, Scene} from "excalibur";
import Formation from "../../aliens/formation";
import Game from "../../game";
import Border from "../../hud/border";
import Score from "../../hud/score";
import Player from "../../player/player";

export default class Level1 extends Scene {
    private scoreTime = 0;

    constructor(private readonly game: Game) {
        super(game.engine);

        const player = new Player(game);
        this.add(player);

        this.add(new Score(game));
        this.add(new Border(game));

        const formation = new Formation(game, player);
        this.add(formation);

        for (const alien of formation.getAliens()) {
            this.add(alien);
        }
    }

    public onActivate(): void {
        this.game.engine.backgroundColor = Color.fromHex("000000");
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