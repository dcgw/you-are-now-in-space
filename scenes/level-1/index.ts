import {Color, Scene} from "excalibur";
import Border from "../../actors/border";
import Player from "../../actors/player";
import Score from "../../actors/score";
import Game from "../../game";

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