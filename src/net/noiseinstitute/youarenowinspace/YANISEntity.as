package net.noiseinstitute.youarenowinspace
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
    import net.noiseinstitute.youarenowinspace.behaviours.IBehaviour;

    public class YANISEntity extends Entity {

        public var behaviour :IBehaviour;

		public function YANISEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
			super(x, y, graphic, mask);
		}
		
		override public function update():void {
            if (behaviour != null) {
                behaviour.update();
            }
            super.update();
		}
	}
}