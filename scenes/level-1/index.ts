import {Color, Scene} from "excalibur";
import Formation from "../../aliens/formation";
import Game from "../../game";
import Border from "../../hud/border";
import Score from "../../hud/score";
import Player from "../../player/player";

export default class Level1 extends Scene {
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
    }
}