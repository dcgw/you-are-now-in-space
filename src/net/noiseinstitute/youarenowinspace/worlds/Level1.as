package net.noiseinstitute.youarenowinspace.worlds {
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Text;
    import net.noiseinstitute.youarenowinspace.*;
    import net.noiseinstitute.youarenowinspace.behaviours.PlayerDefaultBehaviour;
    import net.noiseinstitute.youarenowinspace.entities.Alien;
    import net.noiseinstitute.youarenowinspace.entities.Border;
    import net.noiseinstitute.youarenowinspace.entities.KevinToms;
    import net.noiseinstitute.youarenowinspace.entities.Player;
    import net.noiseinstitute.youarenowinspace.entities.Score;

    public class Level1 extends World {

        [Embed(source = '../data/Adore64.ttf', embedAsCFF="false", fontFamily = 'C64')]
        private static const C64_FONT:Class;

        [Embed(source="Alert.mp3")]
        private static var ALERT:Class;

        private static const PLAY_WIDTH:int = 320;
        private static const PLAY_HEIGHT:int = 200;

        private var playX:int = (FP.screen.width - PLAY_WIDTH)/2;
        private var playY:int = (FP.screen.height - PLAY_HEIGHT)/2;

        private var formation:AlienFormationController;
        private var winMessage:Entity;
        private var player:Player;
        private var playerBehaviour:PlayerDefaultBehaviour;
        private var handleBreakaway:Boolean = false;
        private var kevinToms:KevinToms;
        private var border:Border;
        private var stage:int;

        private var scoreTime:int = 1200;
        private var goalTime:int = 60;

        private var alertChannel:SoundChannel;
        private var gotKevinTomsPoints:Boolean = false;
        private var winText:Text;

        public function Level1 (stage:int) {
            this.stage = stage;
            
            FP.screen.color = 0xff000000;

            player = new Player();
            player.x = (FP.screen.width - player.width)/2;
            player.y = playY;
            player.behaviour = playerBehaviour = new PlayerDefaultBehaviour(player);
            add(player);

            var me:Level1 = this;
            player.onDie = function():void {
                finish(new Intermission(me.stage));
            }

            formation = new AlienFormationController(stage, playX, playY, PLAY_WIDTH, PLAY_HEIGHT, player);
            for each (var alien:Alien in formation.aliens) {
                add(alien);
                alien.onDie = function():void {
                    Main.score += scoreTime*stage / 5;
                }
            }

            winMessage = new Entity();
            winMessage.x = playX + 80;
            winMessage.y = playY + 32;
            winText = new Text("GOAL!", 0, 0, 320);
            winText.font = "C64";
            winText.size = 16;
            winMessage.graphic = winText;
            winMessage.visible = false;
            add(winMessage);

            kevinToms = new KevinToms();
            kevinToms.x = playX + 32;
            kevinToms.y = playY + 56;
            kevinToms.visible = false;
            add(kevinToms);

            border = new Border();
            border.x = -(Border.WIDTH - FP.screen.width) / 2;
            border.y = -(Border.HEIGHT - FP.screen.height) / 2;
            border.layer = -1;
            add(border);

            var score:Score = new Score();
            score.layer = -2;
            add(score);
        }

        override public function update ():void {
            super.update();
            formation.update();

            if (--scoreTime <= 0) {
                finish();
            }

            if (formation.allDead) {
                if (!gotKevinTomsPoints) {
                    var kevinTomsPoints:int = 2000 * stage;
                    winText.text = "GOAL! " + kevinTomsPoints.toString(10);
                    Main.score += kevinTomsPoints;
                    gotKevinTomsPoints = true;
                }
                winMessage.visible = true;
                kevinToms.visible = true;
                if (FP.screen.color == 0xffb8c76f) {
                    FP.screen.color = 0xff000000;
                } else {
                    FP.screen.color = 0xffb8c76f;
                }

                if (--goalTime <= 0) {
                    finish();
                }
            }

            if (formation.breakaway && !handleBreakaway) {
                handleBreakaway = true;
                alertChannel = Sound(new ALERT()).play(0, int.MAX_VALUE);
                border.alert = true;
                playerBehaviour.fixedX = true;
            }
        }

        private function finish (world:World=null):void {
            if (world == null) {
                world = new GetReadyWorld(stage+1);
            }
            if (alertChannel) {
                alertChannel.stop();
            }
            FP.world = world;
        }
    }
}
