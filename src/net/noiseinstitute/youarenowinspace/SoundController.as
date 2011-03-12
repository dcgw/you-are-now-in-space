package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.Sfx;

	public class SoundController {
		
		[Embed(source = 'data/move1.mp3')]
		private const MOVE1_SOUND:Class;
		[Embed(source = 'data/move2.mp3')]
		private const MOVE2_SOUND:Class;
		[Embed(source = 'data/move3.mp3')]
		private const MOVE3_SOUND:Class;
		[Embed(source = 'data/move4.mp3')]
		private const MOVE4_SOUND:Class;
		private const MAX_SOUND_INTERVAL:Number = 20;
		private const MIN_SOUND_INTERVAL:Number = 5;
		
		private var moveSounds:Array;
		private var soundPos:Number = 0;

		public function SoundController() {
			moveSounds = [new Sfx(MOVE1_SOUND), new Sfx(MOVE2_SOUND), new Sfx(MOVE3_SOUND), new Sfx(MOVE4_SOUND)];
		}
		
		public function makeSound():void {
			(moveSounds[soundPos] as Sfx).play();
			soundPos++;
			if(soundPos >= moveSounds.length) {
				soundPos = 0;
			}
		}
	}
}