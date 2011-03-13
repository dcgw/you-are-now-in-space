package net.noiseinstitute.youarenowinspace.worlds {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Text;
    import net.noiseinstitute.youarenowinspace.*;
    import net.noiseinstitute.youarenowinspace.behaviours.PlayerDefaultBehaviour;
    import net.noiseinstitute.youarenowinspace.entities.Alien;
    import net.noiseinstitute.youarenowinspace.entities.KevinToms;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class Level1 extends World {
		
		[Embed(source = '../data/Adore64.ttf', embedAsCFF="false", fontFamily = 'C64')]
		private const C64_FONT:Class;
		
		private var formation:AlienFormationController;
		private var winMsg:Entity;
		private var player:Player;
        private var playerBehaviour:PlayerDefaultBehaviour;
		private var handleBreakaway:Boolean = false;
        private var kevinToms:KevinToms;

		public function Level1 () {
			formation = new AlienFormationController();
            for each (var alien:Alien in formation.aliens) {
                add(alien);
            }

            player = new Player();
            player.behaviour = playerBehaviour = new PlayerDefaultBehaviour(player);
            add(player);

			winMsg = new Entity();
			Text.font = "C64";
			var txt:Text = new Text("GOAL!");
            txt.x = 80;
            txt.y = 32;
			txt.size = 16;
			winMsg.graphic = txt;
			winMsg.visible = false;
			add(winMsg);

            kevinToms = new KevinToms();
            kevinToms.x = 32;
            kevinToms.y = 56;
            kevinToms.visible = false;
            add(kevinToms);
		}
		
		override public function update():void {
			super.update();
			formation.update();
			
			if(formation.allDead) {
				winMsg.visible = true;
                kevinToms.visible = true;
                if (FP.screen.color == 0xffb8c76f) {
                    FP.screen.color = 0xff000000;
                } else {
                    FP.screen.color = 0xffb8c76f;
                }
			}
			
			if(formation.breakaway && !handleBreakaway) {
				handleBreakaway = true;
                playerBehaviour.fixedX = true;
			}
		}
    }
}
