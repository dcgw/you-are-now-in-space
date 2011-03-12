package net.noiseinstitute.youarenowinspace.entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class Bullet extends Entity {
		public function Bullet(x:Number=0, y:Number=0) {
			this.x = x;
			this.y = y;
			setHitbox(5,5);
			type = "bullet";
		}
		
		override public function destroy():void {
			FP.world.remove(this);
		}
	}
}