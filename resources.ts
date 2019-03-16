import {Sound, Texture} from "excalibur";
import alienSplodeMp3 from "./actors/alien-splode.mp3";
import alienSplodeOgg from "./actors/alien-splode.ogg";
import alien from "./actors/alien.png";
import bullet from "./actors/bullet.png";
import laserMp3 from "./actors/laser.mp3";
import laserOgg from "./actors/laser.ogg";
import move1Mp3 from "./actors/move1.mp3";
import move1Ogg from "./actors/move1.ogg";
import move2Mp3 from "./actors/move2.mp3";
import move2Ogg from "./actors/move2.ogg";
import move3Mp3 from "./actors/move3.mp3";
import move3Ogg from "./actors/move3.ogg";
import move4Mp3 from "./actors/move4.mp3";
import move4Ogg from "./actors/move4.ogg";
import playerSplodeMp3 from "./actors/player-splode.mp3";
import playerSplodeOgg from "./actors/player-splode.ogg";
import player from "./actors/player.png";
import score from "./actors/score.png";
import getReadyMusicMp3 from "./scenes/get-ready/get-ready.mp3";
import getReadyMusicOgg from "./scenes/get-ready/get-ready.ogg";
import getReady from "./scenes/get-ready/get-ready.png";
import titleBackground from "./scenes/title/background.png";
import titleMusicMp3 from "./scenes/title/title.mp3";
import titleMusicOgg from "./scenes/title/title.ogg";
import title from "./scenes/title/title.png";

const resources = {
    alien: new Texture(alien),
    alienSplode: new Sound(alienSplodeOgg, alienSplodeMp3),
    bullet: new Texture(bullet),
    getReady: new Texture(getReady),
    getReadyMusic: new Sound(getReadyMusicOgg, getReadyMusicMp3),
    laser: new Sound(laserOgg, laserMp3),
    move1: new Sound(move1Ogg, move1Mp3),
    move2: new Sound(move2Ogg, move2Mp3),
    move3: new Sound(move3Ogg, move3Mp3),
    move4: new Sound(move4Ogg, move4Mp3),
    player: new Texture(player),
    playerSplode: new Sound(playerSplodeMp3, playerSplodeOgg),
    score: new Texture(score),
    title: new Texture(title),
    titleBackground: new Texture(titleBackground),
    titleMusic: new Sound(titleMusicOgg, titleMusicMp3)
};

export default resources;