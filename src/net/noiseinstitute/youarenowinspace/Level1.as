package net.noiseinstitute.youarenowinspace {
    import flashx.textLayout.formats.FormatValue;
    
    import net.flashpunk.World;
    import net.noiseinstitute.youarenowinspace.entities.Alien;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class Level1 extends World {
		
		private var formation:AlienFormationController;

		public function Level1 () {
            formation = new AlienFormationController();
            for each (var alien:Alien in formation.aliens) {
                add(alien);
            }

            var player:Player = new Player();
            add(player);
            var ctrl:Controller = new Controller(player);
        }
		
		override public function update():void {
			super.update();
			formation.update();
		}
    }
}
