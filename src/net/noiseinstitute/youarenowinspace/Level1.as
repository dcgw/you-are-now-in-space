package net.noiseinstitute.youarenowinspace {
    import net.flashpunk.World;
    import net.noiseinstitute.youarenowinspace.entities.Alien;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class Level1 extends World {
        public function Level1 () {
            var formation:AlienFormationController = new AlienFormationController();
            for each (var alien:Alien in formation.aliens) {
                add(alien);
            }

            var player:Player = new Player();
            add(player);
            var ctrl:Controller = new Controller(player);
        }
    }
}
