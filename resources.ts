import {Sound, Texture} from "excalibur";
import getReadyMusicMp3 from "./scenes/get-ready/GetReady.mp3";
import getReadyMusicOgg from "./scenes/get-ready/GetReady.ogg";
import getReady from "./scenes/get-ready/GetReady.png";
import titleMusicMp3 from "./scenes/title/Title.mp3";
import titleMusicOgg from "./scenes/title/Title.ogg";
import title from "./scenes/title/Title.png";
import titleImage from "./scenes/title/TitleImage.png";

const resources = {
    getReady: new Texture(getReady),
    getReadyMusic: new Sound(getReadyMusicOgg, getReadyMusicMp3),
    title: new Texture(title),
    titleImage: new Texture(titleImage),
    titleMusic: new Sound(titleMusicOgg, titleMusicMp3)
};

export default resources;