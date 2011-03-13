package net.noiseinstitute.youarenowinspace.worlds {
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

    public class Level1 extends World {

        [Embed(source = '../data/Adore64.ttf', embedAsCFF="false", fontFamily = 'C64')]
        private static const C64_FONT:Class;

        private static const PLAY_WIDTH:int = 320;
        private static const PLAY_HEIGHT:int = 200;

        private var playX:int = (FP.screen.width - PLAY_WIDTH)/2;
        private var playY:int = (FP.screen.height - PLAY_HEIGHT)/2;

        private var formation:AlienFormationController;
        private var winMsg:Entity;
        private var player:Player;
        private var playerBehaviour:PlayerDefaultBehaviour;
        private var handleBreakaway:Boolean = false;
        private var kevinToms:KevinToms;
        private var border:Border;

        public function Level1 () {
            FP.screen.color = 0xff000000;

            formation = new AlienFormationController(playX, playY, PLAY_WIDTH, PLAY_HEIGHT);
            for each (var alien:Alien in formation.aliens) {
                add(alien);
            }

            player = new Player();
            player.x = (FP.screen.width - player.width)/2;
            player.y = playY;
            player.behaviour = playerBehaviour = new PlayerDefaultBehaviour(player);
            add(player);

            winMsg = new Entity();
            Text.font = "C64";
            var txt:Text = new Text("GOAL!");
            txt.x = playX + 80;
            txt.y = playY + 32;
            txt.size = 16;
            winMsg.graphic = txt;
            winMsg.visible = false;
            add(winMsg);

            kevinToms = new KevinToms();
            kevinToms.x = playX + 32;
            kevinToms.y = playY + 56;
            kevinToms.visible = false;
            add(kevinToms);

            border = new Border();
            border.x = -(Border.WIDTH - FP.screen.width) / 2;
            border.y = -(Border.HEIGHT - FP.screen.height) / 2;
            border.layer = int.MIN_VALUE;
            add(border);
        }

        override public function update ():void {
            super.update();
            formation.update();

            if (formation.allDead) {
                winMsg.visible = true;
                kevinToms.visible = true;
                if (FP.screen.color == 0xffb8c76f) {
                    FP.screen.color = 0xff000000;
                } else {
                    FP.screen.color = 0xffb8c76f;
                }
            }

            if (formation.breakaway && !handleBreakaway) {
                handleBreakaway = true;
                border.alert = true;
                playerBehaviour.fixedX = true;
            }
        }
    }
}
