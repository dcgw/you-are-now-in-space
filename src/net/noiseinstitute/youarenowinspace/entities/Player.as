package net.noiseinstitute.youarenowinspace.entities
{
	import net.flashpunk.graphics.Spritemap;
	import net.noiseinstitute.youarenowinspace.ControllableEntity;
	
	public class Player extends ControllableEntity {
		
		[Embed(source = 'Player.png')]
		private const PLAYER_SPRITEMAP:Class;

		public function Player() {
            var animation:Spritemap = new Spritemap(PLAYER_SPRITEMAP, 21, 24);
            graphic = animation;
            animation.add("spinning", [0,1,2,3,4,5,6], 0.25)
            animation.play("spinning");
			width = 21;
			height = 24;
		}
	}
}