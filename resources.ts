import {Dictionary} from "dictionary-types";
import {Texture} from "excalibur";
import sword from "./images/sword.png";

export const resources: Dictionary<Texture> = {
    Sword: new Texture(sword)
};