package net.noiseinstitute.youarenowinspace {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;

    [SWF(width="768", height="576", backgroundColor="#000000", frameRate="60")]
    public class Preloader extends Sprite {
        private static const MAIN_CLASS_NAME:String ="net.noiseinstitute.youarenowinspace.Main";

        private static const PROGRESS_BAR_BACKGROUND_COLOUR:uint = 0x000000;
        private static const PROGRESS_BAR_FOREGROUND_COLOUR:uint = 0xFFFFFF;

        private static const PROGRESS_BAR_FRAME_SIZE:int = 2;

        private static const MIN_COLOUR_BAR_SIZE:int = 1152;
        private static const MAX_COLOUR_BAR_SIZE:int = 4608;

        private static const COLOUR_BAR_ZOOM:int = 2;

        private static var colours:Vector.<int> = new <int>[
                0x000000, 0xFFFFFF, 0x68372B, 0x70A4B2, 0x6F3D86, 0x588D43, 0x352879, 0xB8C76F,
                0x6f4f25, 0x433900, 0x9A6759, 0x444444, 0x6C6C6C, 0x9AD284, 0x6C5EB5, 0x959595];

        private var colourIndex:int = 0;
        private var colourBarSize:int = 0;

        private var progressBar:Shape;

        private var progressBarX:int;
        private var progressBarY:int;

        private var progressBarWidth:int;
        private var progressBarHeight:int;

        private var colourBars:BitmapData;

        public function Preloader() {
            const stageWidth:int = stage.stageWidth;
            const stageHeight:int = stage.stageHeight;

            colourBars = new BitmapData(stageWidth / COLOUR_BAR_ZOOM, stageHeight / COLOUR_BAR_ZOOM, false, colours[0]);
            var colourBarsBitmap:Bitmap = new Bitmap(colourBars);
            colourBarsBitmap.scaleX = 2;
            colourBarsBitmap.scaleY = 2;
            colourBarsBitmap.smoothing = false;
            addChild(colourBarsBitmap);

            progressBarWidth = stageWidth * 0.8;
            progressBarHeight = 20;

            progressBarX = (stageWidth - progressBarWidth) * 0.5;
            progressBarY = (stageHeight - progressBarHeight) * 0.5;

            var frame:Shape = new Shape();

            frame.graphics.beginFill(PROGRESS_BAR_BACKGROUND_COLOUR);
            frame.graphics.drawRect(progressBarX - PROGRESS_BAR_FRAME_SIZE*2,
                    progressBarY - PROGRESS_BAR_FRAME_SIZE*2,
                    progressBarWidth + PROGRESS_BAR_FRAME_SIZE * 4,
                    progressBarHeight + PROGRESS_BAR_FRAME_SIZE * 4);
            frame.graphics.endFill();

            frame.graphics.beginFill(PROGRESS_BAR_FOREGROUND_COLOUR);
            frame.graphics.drawRect(progressBarX - PROGRESS_BAR_FRAME_SIZE,
                    progressBarY - PROGRESS_BAR_FRAME_SIZE,
                    progressBarWidth + PROGRESS_BAR_FRAME_SIZE * 2,
                    progressBarHeight + PROGRESS_BAR_FRAME_SIZE * 2);
            frame.graphics.endFill();

            addChild(frame);

            progressBar = new Shape();
            addChild(progressBar);

            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(e:Event):void {
            if (hasLoaded()) {
                start();
            } else {
                colourBars.lock();
                var position:int = 0;
                const maxPosition:int = colourBars.width * colourBars.height;
                while (position < maxPosition) {
                    while (colourBarSize > 0 && position < maxPosition) {
                        colourBars.setPixel(position % colourBars.width, position / colourBars.width, colours[colourIndex]);
                        ++position;
                        --colourBarSize;
                    }
                    if (position < maxPosition) {
                        colourIndex = (colourIndex + 1) % colours.length;
                        colourBarSize = MIN_COLOUR_BAR_SIZE + Math.random() * (MAX_COLOUR_BAR_SIZE - MIN_COLOUR_BAR_SIZE);
                    }
                }
                colourBars.unlock();

                var progress:Number = (loaderInfo.bytesLoaded / loaderInfo.bytesTotal);
                if (isNaN(progress)) {
                    progress = 0;
                }

                progressBar.graphics.clear();
                progressBar.graphics.beginFill(PROGRESS_BAR_BACKGROUND_COLOUR);
                progressBar.graphics.drawRect(progressBarX, progressBarY,
                        progress * progressBarWidth, progressBarHeight);
                progressBar.graphics.endFill();
            }
        }

        private function hasLoaded():Boolean {
            return (loaderInfo.bytesLoaded >= loaderInfo.bytesTotal);
        }

        private function start():void {
            stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);

            var mainClass:Class = Class(getDefinitionByName(MAIN_CLASS_NAME));
            parent.addChild(DisplayObject(new mainClass));

            parent.removeChild(this);
        }
    }
}
