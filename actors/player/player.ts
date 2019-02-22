import {Actor, Color} from "excalibur";

export default class Player extends Actor {
    constructor() {
        super();
        this.setWidth(25);
        this.setHeight(25);
        this.x = 150;
        this.y = 150;
        this.color = new Color(255, 255, 255);
    }
}
