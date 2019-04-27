import {Color, Scene} from "excalibur";
import Game from "../../game";
import Border from "../../hud/border";
import Score from "../../hud/score";
import Player from "../../player/player";

export default class Level1 extends Scene {
    constructor(private readonly game: Game) {
        super(game.engine);

        this.add(new Player(game));
        this.add(new Score(game));
        this.add(new Border(game));
    }

    public onActivate(): void {
        this.game.engine.backgroundColor = Color.fromHex("000000");
    }
}