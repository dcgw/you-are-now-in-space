import {Sound, Texture} from "excalibur";
import playerSplodeMp3 from "./actors/player-splode.mp3";
import playerSplodeOgg from "./actors/player-splode.ogg";
import score from "./actors/score.png";
import getReadyMusicMp3 from "./scenes/get-ready/get-ready.mp3";
import getReadyMusicOgg from "./scenes/get-ready/get-ready.ogg";
import getReady from "./scenes/get-ready/get-ready.png";
import titleBackground from "./scenes/title/background.png";
import titleMusicMp3 from "./scenes/title/title.mp3";
import titleMusicOgg from "./scenes/title/title.ogg";
import title from "./scenes/title/title.png";

const resources = {
    getReady: new Texture(getReady),
    getReadyMusic: new Sound(getReadyMusicOgg, getReadyMusicMp3),
    playerSplode: new Sound(playerSplodeMp3, playerSplodeOgg),
    score: new Texture(score),
    title: new Texture(title),
    titleBackground: new Texture(titleBackground),
    titleMusic: new Sound(titleMusicOgg, titleMusicMp3)
};

export default resources;