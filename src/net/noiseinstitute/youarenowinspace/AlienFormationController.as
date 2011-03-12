package net.noiseinstitute.youarenowinspace {
    import net.flashpunk.FP;
    import net.noiseinstitute.youarenowinspace.entities.Alien;

    public class AlienFormationController {

        static const ALIENS_HORIZONTAL:uint = 8;
        static const ALIEN_COLOURS:Vector.<String> = Vector.<String>(
                [Alien.RED, Alien.BROWN, Alien.GREY, Alien.GREEN]);

        private var _aliens:Vector.<Vector.<Alien>> = new Vector.<Vector.<Alien>>();
        public function get aliens():Vector.<Alien> {
            var value:Vector.<Alien> = new Vector.<Alien>();
            for each (var v:Vector.<Alien> in _aliens) {
                value = value.concat(v);
            }
            return value;
        }

        private var lastUpdatedI:uint = ALIEN_COLOURS.length - 1;
        private var lastUpdatedJ:uint = ALIENS_HORIZONTAL - 1;

        private static const LEFT_MARGIN:int = 22;
        private static const BOTTOM_MARGIN:int = 11;

        public function AlienFormationController () {
            var i:int = 0;
            for each (var colour in ALIEN_COLOURS) {
                _aliens[i] = new Vector.<Alien>();
                for (var j:int=0; j<ALIENS_HORIZONTAL; ++j) {
                    _aliens[i][j] = new Alien(colour);
                    _aliens[i][j].x = j * 36 + LEFT_MARGIN;
                    _aliens[i][j].y = FP.height - _aliens[i][j].height - BOTTOM_MARGIN - i * 24;
                }
                ++i;
            }
        }
    }
}
