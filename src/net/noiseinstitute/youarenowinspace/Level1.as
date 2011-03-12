package net.noiseinstitute.youarenowinspace {
    import flashx.textLayout.formats.FormatValue;
    
    import net.flashpunk.Entity;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Text;
    import net.noiseinstitute.youarenowinspace.entities.Alien;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class Level1 extends World {
		
		[Embed(source = 'data/Adore64.ttf', embedAsCFF="false", fontFamily = 'C64')]
		private const C64_FONT:Class;
		
		private var formation:AlienFormationController;
		private var winMsg:Entity;

		public function Level1 () {
            formation = new AlienFormationController();
            for each (var alien:Alien in formation.aliens) {
                add(alien);
            }

            var player:Player = new Player();
            add(player);
            var ctrl:Controller = new Controller(player);
			
			winMsg = new Entity();
			Text.font = "C64";
			var txt:Text = new Text("GOAL!", 70, 10, 150, 70);
			txt.size = 8;
			winMsg.graphic = txt;
			winMsg.visible = false;
			add(winMsg);
		}
		
		override public function update():void {
			super.update();
			formation.update();
			
			if(formation.allDead) {
				winMsg.visible = true;
			}
		}
    }
}
