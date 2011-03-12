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
		private var soundController:SoundController;

        private static const LEFT_MARGIN:int = 22;
        private static const BOTTOM_MARGIN:int = 11;
		private static const MOVE_AMOUNT:Number = 12;
		
		private var time:Number = 0;
		private var moveInterval:Number= 32;
		private var movePlaces:Number = 4;
		private var directionLeft:Boolean = true;
		private var moveUp:Boolean = false;
		private var formationSize:Number;
		
		private var separationX:Number = 36;
		private var separationY:Number = 24;

		private var formationX:Number = LEFT_MARGIN;
		private var formationY:Number = BOTTOM_MARGIN;
		private var formationW:Number = separationX * ALIENS_HORIZONTAL - (separationX - Alien.WIDTH);
		private var formationH:Number = separationY * ALIEN_COLOURS.length - (separationY - Alien.HEIGHT);

        public function AlienFormationController () {
			soundController = new SoundController();
			
            var i:int = 0;
            for each (var colour:String in ALIEN_COLOURS) {
                _aliens[i] = new Vector.<Alien>();
                for (var j:int=0; j<ALIENS_HORIZONTAL; ++j) {
                    _aliens[i][j] = new Alien(colour);
                    _aliens[i][j].x = j * separationX + LEFT_MARGIN;
                    _aliens[i][j].y = FP.height - _aliens[i][j].height - BOTTOM_MARGIN - i * separationY;
                }
                ++i;
            }
        }
		
		public function get allDead():Boolean {
			return formationSize == 0;
		}
		
		public function update():void {
			if(allDead) {
				return;
			}
			
			time++;
			if(time >= moveInterval) {
				time = 0;
				
				// Find where the aliens are and how many
				var leftmost:Number = FP.screen.width;
				var rightmost:Number = 0;
				var upmost:Number = FP.screen.height;
				formationSize = 0;
				
				for each(var alien:Alien in aliens) {
					if(!alien.dead) {
						formationSize++;
						if(alien.x < leftmost) {
							leftmost = alien.x;
						}
						if(alien.x > rightmost) {
							rightmost = alien.x;
						}
						if(alien.y < upmost) {
							upmost = alien.y;
						}
					}
				}
				
				// Update the movement interval
				moveInterval = formationSize;
				
				// Update the size of the formation
				formationX = leftmost;
				formationY = upmost;
				formationW = rightmost + Alien.WIDTH - formationX;
				
				// Make a sound
				if(!allDead) {
					soundController.makeSound();	
				}
				
				// Move the formation
				if(formationX <= 0 || formationX >= FP.screen.width - formationW) {
					if(moveUp) {
						moveUp = false;
					} else {
						directionLeft = !directionLeft;
						moveUp = true;
					}
				}
				
				var moveAmtX:Number = moveUp ? 0 : (directionLeft ? -MOVE_AMOUNT : MOVE_AMOUNT);
				var moveAmtY:Number = moveUp ? -MOVE_AMOUNT : 0;
				
				formationX += moveAmtX; 
				formationY += moveAmtY;
				
				for each(var alien:Alien in aliens) {
					alien.x += moveAmtX; 
					alien.y += moveAmtY;
				}
			}
		}
    }
}
