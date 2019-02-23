import {Sound, Texture} from "excalibur";
import titleMusicMp3 from "./scenes/title/Title.mp3";
import titleMusicOgg from "./scenes/title/Title.ogg";
import title from "./scenes/title/Title.png";
import titleImage from "./scenes/title/TitleImage.png";

const resources = {
    title: new Texture(title),
    titleImage: new Texture(titleImage),
    titleMusic: new Sound(titleMusicOgg, titleMusicMp3)
};

export default resources;