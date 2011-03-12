package net.noiseinstitute.youarenowinspace.entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.noiseinstitute.youarenowinspace.YANISEntity;
	
	public class Bullet extends YANISEntity {
		
		[Embed(source = 'Bullet.png')]
		private const BULLET_IMAGE:Class;

		public function Bullet(x:Number=0, y:Number=0) {
			this.x = x - 8;
			this.y = y - 8;
			graphic = new Image(BULLET_IMAGE);
			setHitbox(16,16);
			type = "bullet";
		}
		
		override public function update():void {
			y += 10;
			
			// If a bullet goes off screen, get rid of it
			if(y >= FP.screen.height + height) {
				FP.world.remove(this);				
			}
		}
		
		public function destroy():void {
			FP.world.remove(this);
		}
	}
}