import {Dictionary} from "dictionary-types";
import {Texture} from "excalibur";
import sword from "./images/sword.png";

const resources: Dictionary<Texture> = {
    Sword: new Texture(sword)
};

export default resources;