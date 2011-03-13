package net.noiseinstitute.youarenowinspace.behaviours {
    public class ResettableTimer {
        private var _time:int = 0;

        public function get time():uint {
            return _time;
        }

        public function hasElapsed(period:uint):Boolean {
            return _time >= period;
        }

        public function resetTime():void {
            _time = 0;
        }

        public function update():void {
            ++_time;
        }
    }
}
