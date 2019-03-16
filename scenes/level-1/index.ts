import {Color, Scene} from "excalibur";
import Player from "../../actors/player";
import Score from "../../actors/score";
import Game from "../../game";

export default class Level1 extends Scene {
    constructor(private readonly game: Game) {
        super(game.engine);

        this.add(new Player(game));
        this.add(new Score(game));
    }

    public onActivate(): void {
        this.game.engine.backgroundColor = Color.fromHex("000000");
    }
}