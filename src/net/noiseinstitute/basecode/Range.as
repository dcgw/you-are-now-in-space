package net.noiseinstitute.basecode {
    public class Range {
        public static function wrap(n:Number, min:Number, max:Number):Number {
            if (n < min || n > max) {
                n -= min;
                max -= min;
                if (n < 0) {
                    n += max * Math.ceil(-n/max);
                }
                return min + n%max;
            } else {
                return n;
            }
        }
    }
}
