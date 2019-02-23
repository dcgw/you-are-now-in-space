package net.noiseinstitute.youarenowinspace {
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.noiseinstitute.youarenowinspace.behaviours.BrokenFormationBehaviour;
    import net.noiseinstitute.youarenowinspace.entities.Alien;
    import net.noiseinstitute.youarenowinspace.entities.AlienBullet;
    import net.noiseinstitute.youarenowinspace.entities.Player;

    public class AlienFormationController {

        [Embed(source="AlienShot.mp3")]
        private static const SHOT_SOUND:Class;

        private static const ALIENS_HORIZONTAL:uint = 8;
        private static const ALIEN_COLOURS:Vector.<String> = Vector.<String>(
                [Alien.RED, Alien.BROWN, Alien.GREY, Alien.GREEN]);

        private static const LEFT_MARGIN:int = 22;
        private static const BOTTOM_MARGIN:int = 11;
        private static const BREAKAWAY_MARGIN:int = 60;
        private static const MOVE_AMOUNT:Number = 6;
        private static const SHOOT_INTERVAL:int = 180;
        private static const BULLET_MIN_SPEED:int = 2;
        private static const BULLET_SPEED_INCREMENT:Number = 0.5;

        private var _aliens:Vector.<Vector.<Alien>> = new Vector.<Vector.<Alien>>();

        public function get aliens ():Vector.<Alien> {
            var value:Vector.<Alien> = new Vector.<Alien>();
            for each (var v:Vector.<Alien> in _aliens) {
                value = value.concat(v);
            }
            return value;
        }

        private var soundController:SoundController;

        private var stage:int;
        private var playX:int;
        private var playY:int;
        private var playWidth:int;
        private var playHeight:int;

        private var time:Number = 0;
        private var moveInterval:Number = 32;
        private var directionLeft:Boolean = true;
        private var moveVertically:Boolean = false;
        private var formationSize:Number;
        private var _breakaway:Boolean = false;

        private var separationX:Number = 36;
        private var separationY:Number = 24;

        private var formationX:Number = LEFT_MARGIN;
        private var formationY:Number = BOTTOM_MARGIN;
        private var formationW:Number = separationX * ALIENS_HORIZONTAL - (separationX - Alien.WIDTH);

        private var shootTimer:int;
        private var player:Player;

        public function AlienFormationController (stage:int, x:int, y:int, width:int, height:int, player:Player) {
            this.stage = stage;
            playX = x;
            playY = y;
            playWidth = width;
            playHeight = height;

            this.player = player;

            shootTimer = SHOOT_INTERVAL/stage;

            soundController = new SoundController();

            var i:int = 0;
            for each (var colour:String in ALIEN_COLOURS) {
                _aliens[i] = new Vector.<Alien>();
                for (var j:int = 0; j < ALIENS_HORIZONTAL; ++j) {
                    _aliens[i][j] = new Alien(colour);
                    _aliens[i][j].x = playX + j * separationX + LEFT_MARGIN;
                    _aliens[i][j].y = playY + playHeight - _aliens[i][j].height - BOTTOM_MARGIN - i * separationY;
                }
                ++i;
            }
        }

        public function get allDead ():Boolean {
            return formationSize == 0;
        }

        public function get breakaway ():Boolean {
            return _breakaway;
        }

        public function update ():void {
            if (allDead) {
                return;
            }

            // Find where the aliens are and how many
            var leftmost:Number = playX + playWidth;
            var rightmost:Number = playX;
            var upmost:Number = playY + playHeight;
            formationSize = 0;
            var nonBrokenFormationSize:int = 0;

            var alien:Alien;
            for each(alien in aliens) {
                if (!alien.dead) {
                    formationSize++;

                    // If they're in formation
                    if (!alien.behaviour) {
                        nonBrokenFormationSize++;

                        if (alien.x < leftmost) {
                            leftmost = alien.x;
                        }
                        if (alien.x > rightmost) {
                            rightmost = alien.x;
                        }
                        if (alien.y < upmost) {
                            upmost = alien.y;
                        }
                    }
                }
            }

            time++;
            if (time >= moveInterval) {
                time = 0;

                // Update the movement interval
                moveInterval = formationSize - (stage-1)*4;

                // Update the size of the formation
                formationX = leftmost;
                formationY = upmost;
                formationW = rightmost + Alien.WIDTH - formationX;

                // Make a sound
                if (!allDead) {
                    soundController.makeSound();
                }

                // Move the formation
                if (formationX <= playX || formationX >= (playX + playWidth) - formationW) {
                    if (moveVertically) {
                        moveVertically = false;
                    } else {
                        directionLeft = !directionLeft;
                        moveVertically = true;
                    }
                }

                var moveAmtX:Number = 0;
                var moveAmtY:Number = 0;

                if (moveVertically) {
                    if (player.y < formationY) {
                        moveAmtY = -MOVE_AMOUNT;
                    } else {
                        moveAmtY = MOVE_AMOUNT;
                    }
                } else {
                    moveAmtX = directionLeft
                            ? -MOVE_AMOUNT
                            : MOVE_AMOUNT;
                }

                formationX += moveAmtX;
                formationY += moveAmtY;

                for each(alien in aliens) {
                    if (!alien.dead && !alien.behaviour) {
                        alien.x += moveAmtX;
                        alien.y += moveAmtY;
                    }
                }

                if (upmost <= playY + BREAKAWAY_MARGIN) {
                    _breakaway = true;
                }
            }

            var shooting:Boolean = false;
            if (--shootTimer <= 0) {
                shooting = true;
                shootTimer = SHOOT_INTERVAL/stage;
            }

            var selected:int;
            var i:int;

            if ((_breakaway || shooting) && nonBrokenFormationSize > 0) {
                selected = Math.floor(Math.random() * nonBrokenFormationSize);

                i = 0;
                for each(alien in aliens) {
                    if (!alien.dead && !alien.behaviour) {
                        if (i == selected) {
                            if (_breakaway) {
                                alien.behaviour = new BrokenFormationBehaviour(alien);
                            } else if (shooting) {
                                if (stage >= 5 && (
                                        player.x > playX + playWidth ||
                                        player.x - player.width < playX)) {
                                    shootTowardsPlayer(alien);
                                } else {
                                    shootVertically(alien);
                                }
                            }
                            break;
                        }
                        ++i;
                    }
                }
            }

            if (_breakaway && shooting && stage >= 5) {
                selected = Math.floor(Math.random() * formationSize);

                i = 0;
                for each(alien in aliens) {
                    if (!alien.dead) {
                        if (i == selected) {
                            shootTowardsPlayer(alien);
                        }
                        ++i;
                    }
                }
            }
        }

        private function shootTowardsPlayer (alien:Alien):void {
            var dx:Number = player.centerX - alien.centerX;
            var dy:Number = player.centerY - alien.centerY;
            var distance:Number = Math.sqrt(dx * dx + dy * dy);
            var nx:Number = dx / distance;
            var ny:Number = dy / distance;
            var vx:Number = nx * stage;
            var vy:Number = ny * stage;
            shoot(alien, vx, vy);
        }

        private function shootVertically (alien:Alien):void {
            var vx:Number = 0;
            var vy:Number = BULLET_MIN_SPEED + BULLET_SPEED_INCREMENT * (stage - 1);
            if (player.y < formationY) {
                vy = -vy;
            }
            shoot(alien, vx, vy);
        }


        private function shoot (alien:Alien, vx1:Number, vy1:Number):void {
            new Sfx(SHOT_SOUND).play();
            FP.world.add(new AlienBullet(alien.centerX, alien.centerY, vx1, vy1));
        }
    }
}