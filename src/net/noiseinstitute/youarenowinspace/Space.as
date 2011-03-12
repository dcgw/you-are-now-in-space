package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.noiseinstitute.youarenowinspace.entities.Alien;
	import net.noiseinstitute.youarenowinspace.entities.Player;
	
	public class Space extends World {
		
		[Embed(source = 'data/move1.mp3')]
		private const MOVE1_SOUND:Class;
		[Embed(source = 'data/move2.mp3')]
		private const MOVE2_SOUND:Class;
		[Embed(source = 'data/move3.mp3')]
		private const MOVE3_SOUND:Class;
		[Embed(source = 'data/move4.mp3')]
		private const MOVE4_SOUND:Class;
		private const MAX_SOUND_INTERVAL:uint = 20;
		private const MIN_SOUND_INTERVAL:uint = 5;
		
		private var moveSounds:Array;
		private var soundPos:Number;
		private var soundInterval:uint = MAX_SOUND_INTERVAL;
		private var player:Player;
		private var alienSpawner:AlienSpawner;
		private var time:uint = 0;
		
		public function Space() {
			super();
			
			soundPos = 0;
			moveSounds = [new Sfx(MOVE1_SOUND), new Sfx(MOVE2_SOUND), new Sfx(MOVE3_SOUND), new Sfx(MOVE4_SOUND)];
			
			alienSpawner = new AlienSpawner();
			
			player = new Player();
			add(player)
			var ctrl:Controller = new Controller(player);
		}
		
		override public function update():void {
			super.update();
			alienSpawner.update();
			
			time++;
			if(time > soundInterval) {
				time == 0;
				(moveSounds[soundPos] as Sfx).play();
				soundPos++;
				if(soundPos >= moveSounds.length) {
					soundPos = 0;
				}
			}
		}
	}
}