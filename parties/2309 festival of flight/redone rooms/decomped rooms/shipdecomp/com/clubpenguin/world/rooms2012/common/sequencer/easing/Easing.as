//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing
    {
        function Easing () {
        }
        static function getVal(easeType, time, beginVal, change, duration, a, p) {
            if (!a) {
                a = 0;
            }
            if (!p) {
                p = 0;
            }
            switch (easeType) {
                case BACK_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Back.easeIn(time, beginVal, change, duration, a));
                    return(0);
                case BACK_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Back.easeOut(time, beginVal, change, duration, a));
                    return(0);
                case BACK_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Back.easeInOut(time, beginVal, change, duration, a));
                    return(0);
                case BOUNCE_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Bounce.easeIn(time, beginVal, change, duration));
                    return(0);
                case BOUNCE_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Bounce.easeOut(time, beginVal, change, duration));
                    return(0);
                case BOUNCE_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Bounce.easeInOut(time, beginVal, change, duration));
                    return(0);
                case CIRC_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Circ.easeIn(time, beginVal, change, duration));
                    return(0);
                case CIRC_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Circ.easeOut(time, beginVal, change, duration));
                    return(0);
                case CIRC_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Circ.easeInOut(time, beginVal, change, duration));
                    return(0);
                case CUBIC_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Cubic.easeIn(time, beginVal, change, duration));
                    return(0);
                case CUBIC_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Cubic.easeOut(time, beginVal, change, duration));
                    return(0);
                case CUBIC_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Cubic.easeInOut(time, beginVal, change, duration));
                    return(0);
                case ELASTIC_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Elastic.easeIn(time, beginVal, change, duration, a, p));
                    return(0);
                case ELASTIC_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Elastic.easeOut(time, beginVal, change, duration, a, p));
                    return(0);
                case ELASTIC_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Elastic.easeInOut(time, beginVal, change, duration, a, p));
                    return(0);
                case EXPO_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Expo.easeIn(time, beginVal, change, duration));
                    return(0);
                case EXPO_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Expo.easeOut(time, beginVal, change, duration));
                    return(0);
                case EXPO_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Expo.easeInOut(time, beginVal, change, duration));
                    return(0);
                case LINEAR_NONE : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Linear.easeNone(time, beginVal, change, duration));
                    return(0);
                case LINEAR_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Linear.easeIn(time, beginVal, change, duration));
                    return(0);
                case LINEAR_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Linear.easeOut(time, beginVal, change, duration));
                    return(0);
                case LINEAR_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Linear.easeInOut(time, beginVal, change, duration));
                    return(0);
                case QUAD_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quad.easeIn(time, beginVal, change, duration));
                    return(0);
                case QUAD_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quad.easeOut(time, beginVal, change, duration));
                    return(0);
                case QUAD_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quad.easeInOut(time, beginVal, change, duration));
                    return(0);
                case QUART_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quart.easeIn(time, beginVal, change, duration));
                    return(0);
                case QUART_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quart.easeOut(time, beginVal, change, duration));
                    return(0);
                case QUART_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quart.easeInOut(time, beginVal, change, duration));
                    return(0);
                case QUINT_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quint.easeIn(time, beginVal, change, duration));
                    return(0);
                case QUINT_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quint.easeOut(time, beginVal, change, duration));
                    return(0);
                case QUINT_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Quint.easeInOut(time, beginVal, change, duration));
                    return(0);
                case RANDOM_NONE : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Random.easeNone(time, beginVal, change, duration, a));
                    return(0);
                case RANDOM_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Random.easeIn(time, beginVal, change, duration, a));
                    return(0);
                case RANDOM_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Random.easeOut(time, beginVal, change, duration, a));
                    return(0);
                case RANDOM_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Random.easeInOut(time, beginVal, change, duration, a));
                    return(0);
                case SINE_IN : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Sine.easeIn(time, beginVal, change, duration));
                    return(0);
                case SINE_OUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Sine.easeOut(time, beginVal, change, duration));
                    return(0);
                case SINE_INOUT : 
                    return(com.clubpenguin.world.rooms2012.common.sequencer.easing.Sine.easeInOut(time, beginVal, change, duration));
                    return(0);
            }
            return(0);
        }
        static var BACK_IN = "Back.easeIn";
        static var BACK_OUT = "Back.easeOut";
        static var BACK_INOUT = "Back.easeInOut";
        static var BOUNCE_IN = "Bounce.easeIn";
        static var BOUNCE_OUT = "Bounce.easeOut";
        static var BOUNCE_INOUT = "Bounce.easeInOut";
        static var CIRC_IN = "Circ.easeIn";
        static var CIRC_OUT = "Circ.easeOut";
        static var CIRC_INOUT = "Circ.easeInOut";
        static var CUBIC_IN = "Cubic.easeIn";
        static var CUBIC_OUT = "Cubic.easeOut";
        static var CUBIC_INOUT = "Cubic.easeInOut";
        static var ELASTIC_IN = "Elastic.easeIn";
        static var ELASTIC_OUT = "Elastic.easeOut";
        static var ELASTIC_INOUT = "Elastic.easeInOut";
        static var EXPO_IN = "Expo.easeIn";
        static var EXPO_OUT = "Expo.easeOut";
        static var EXPO_INOUT = "Expo.easeInOut";
        static var LINEAR_NONE = "Linear.easeNone";
        static var LINEAR_IN = "Linear.easeIn";
        static var LINEAR_OUT = "Linear.easeOut";
        static var LINEAR_INOUT = "Linear.easeInOut";
        static var QUAD_IN = "Quad.easeIn";
        static var QUAD_OUT = "Quad.easeOut";
        static var QUAD_INOUT = "Quad.easeInOut";
        static var QUART_IN = "Quart.easeIn";
        static var QUART_OUT = "Quart.easeOut";
        static var QUART_INOUT = "Quart.easeInOut";
        static var QUINT_IN = "Quint.easeIn";
        static var QUINT_OUT = "Quint.easeOut";
        static var QUINT_INOUT = "Quint.easeInOut";
        static var SINE_IN = "Sine.easeIn";
        static var SINE_OUT = "Sine.easeOut";
        static var SINE_INOUT = "Sine.easeInOut";
        static var RANDOM_NONE = "Random.easeNone";
        static var RANDOM_IN = "Random.easeIn";
        static var RANDOM_OUT = "Random.easeOut";
        static var RANDOM_INOUT = "Random.easeInOut";
    }
