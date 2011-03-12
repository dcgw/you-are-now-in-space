package net.noiseinstitute.youarenowinspace.entities
{
	import net.flashpunk.graphics.Image;
	import net.noiseinstitute.youarenowinspace.ControllableEntity;
	
	public class Player extends ControllableEntity {
		
		[Embed(source = 'Player.png')]
		private const PLAYER_IMAGE:Class;

		public function Player() {
			graphic = new Image(PLAYER_IMAGE);
		}
	}
}