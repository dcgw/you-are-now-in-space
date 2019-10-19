import {Color, Engine, Scene} from "excalibur";
import Formation from "../../aliens/formation";
import Game from "../../game";
import Border from "../../hud/border";
import Goal from "../../hud/goal";
import KevinToms from "../../hud/kevin-toms";
import Score from "../../hud/score";
import {black, yellow} from "../../palette";
import Player from "../../player/player";
import resources from "../../resources";

export default class Level1 extends Scene {
    private readonly border = new Border(this.game);
    private readonly player: Player;
    private readonly formation: Formation;
    private readonly goal: Goal;
    private readonly kevinToms: KevinToms;

    private scoreTime = 0;
    private goalTime = 0;
    private handledBreakaway = false;
    private gotKevinTomsBonus = false;

    constructor(private readonly game: Game) {
        super(game.engine);

        this.player = new Player(game);
        this.player.on("kill", () => this.killed());

        this.add(new Score(game));
        this.add(this.border);

        this.formation = new Formation(game, this.player);
        this.formation.on("alienAsploded",
            () => game.score += Math.floor(Math.round(this.scoreTime / 1000 * 60) * game.stage / 5));
        this.add(this.formation);

        this.goal = new Goal(game);
        this.add(this.goal);

        this.kevinToms = new KevinToms(game);
        this.add(this.kevinToms);
    }

    public onActivate(): void {
        this.border.disableAlert();
        this.add(this.player);
        this.player.reset();
        this.formation.reset();
        this.goal.visible = false;

        this.game.engine.backgroundColor = Color.fromHex("000000");

        this.kevinToms.visible = false;
        this.scoreTime = 1200 * 1000 / 60;
        this.goalTime = 60 * 1000 / 60;
        this.handledBreakaway = false;
        this.gotKevinTomsBonus = false;
    }

    public update(engine: Engine, delta: number): void {
        super.update(engine, delta);

        this.scoreTime -= delta;

        if (this.scoreTime <= 0) {
            this.complete();
        }

        if (this.formation.allDead) {
            if (!this.gotKevinTomsBonus) {
                const bonus = 2000 * this.game.stage;
                this.goal.bonus = bonus;
                this.goal.visible = true;
                this.kevinToms.visible = true;
                this.game.score += bonus;
                this.gotKevinTomsBonus = true;
            }

            this.goalTime -= delta;

            if ((this.goalTime * 15 / 1000) & 1) {
                this.game.engine.backgroundColor = black;
            } else {
                this.game.engine.backgroundColor = yellow;
            }

            if (this.goalTime < 0) {
                this.complete();
            }
        }

        if (this.formation.isBreakaway() && !this.handledBreakaway) {
            this.handledBreakaway = true;
            resources.alert.loop = true;
            resources.alert.play()
                .then(() => void 0,
                    reason => console.error("", reason));
            this.border.enableAlert();
            this.player.fixedX = true;
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