import sword from './images/sword.png';
import {Dictionary} from "dictionary-types";
import {Texture} from "excalibur";

let Resources: Dictionary<Texture> = {
    Sword: new Texture(sword)
};

export { Resources }
