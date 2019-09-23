import {Sound, Texture} from "excalibur";
import alienBullet from "./aliens/alien-bullet.png";
import alienShotMp3 from "./aliens/alien-shot.mp3";
import alienShotOgg from "./aliens/alien-shot.ogg";
import alienSplodeMp3 from "./aliens/alien-splode.mp3";
import alienSplodeOgg from "./aliens/alien-splode.ogg";
import alien from "./aliens/alien.png";
import move1Mp3 from "./aliens/move1.mp3";
import move1Ogg from "./aliens/move1.ogg";
import move2Mp3 from "./aliens/move2.mp3";
import move2Ogg from "./aliens/move2.ogg";
import move3Mp3 from "./aliens/move3.mp3";
import move3Ogg from "./aliens/move3.ogg";
import move4Mp3 from "./aliens/move4.mp3";
import move4Ogg from "./aliens/move4.ogg";
import border from "./hud/border.png";
import score from "./hud/score.png";
import bullet from "./player/bullet.png";
import laserMp3 from "./player/laser.mp3";
import laserOgg from "./player/laser.ogg";
import playerSplodeMp3 from "./player/player-splode.mp3";
import playerSplodeOgg from "./player/player-splode.ogg";
import player from "./player/player.png";
import getReadyMusicMp3 from "./scenes/get-ready/get-ready.mp3";
import getReadyMusicOgg from "./scenes/get-ready/get-ready.ogg";
import getReady from "./scenes/get-ready/get-ready.png";
import intermissionMusicMp3 from "./scenes/intermission/intermission.mp3";
import intermissionMusicOgg from "./scenes/intermission/intermission.ogg";
import intermission from "./scenes/intermission/intermission.png";
import titleBackground from "./scenes/title/background.png";
import titleMusicMp3 from "./scenes/title/title.mp3";
import titleMusicOgg from "./scenes/title/title.ogg";
import title from "./scenes/title/title.png";

const resources = {
    alien: new Texture(alien),
    alienBullet: new Texture(alienBullet),
    alienShot: new Sound(alienShotOgg, alienShotMp3),
    alienSplode: new Sound(alienSplodeOgg, alienSplodeMp3),
    border: new Texture(border),
    bullet: new Texture(bullet),
    getReady: new Texture(getReady),
    getReadyMusic: new Sound(getReadyMusicOgg, getReadyMusicMp3),
    intermission: new Texture(intermission),
    intermissionMusic: new Sound(intermissionMusicOgg, intermissionMusicMp3),
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