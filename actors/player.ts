import {Actor} from "excalibur";

const width = 21;
const height = 24;

export default class Player extends Actor {
    constructor() {
        super({
            width,
            height
        });
    }
}