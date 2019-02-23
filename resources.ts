import {Sound, Texture} from "excalibur";
import titleMusic from "./scenes/title/Title.mp3";
import title from "./scenes/title/Title.png";
import titleImage from "./scenes/title/TitleImage.png";

const resources = {
    title: new Texture(title),
    titleImage: new Texture(titleImage),
    titleMusic: new Sound(titleMusic)
};

export default resources;