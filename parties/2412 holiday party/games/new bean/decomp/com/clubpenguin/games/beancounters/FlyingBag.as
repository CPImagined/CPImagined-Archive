//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.FlyingBag extends com.clubpenguin.games.beancounters.FlyingObject
    {
        var __colored, __color, animationClip, bag, coloredPart, __bagColor, __colorIndex, __gc, __get__GameEngine;
        function FlyingBag () {
            super();
            __colored = false;
        }
        function get color() {
            return(__color);
        }
        function set color(param) {
            __color = param;
            //return(color);
        }
        function startAnimation() {
            animationClip = bag.bag_mc;
            coloredPart = animationClip.colored_part;
            animationClip.gotoAndPlay(1);
        }
        function setColor(color) {
            __bagColor = color;
            var _local_2 = new Color(coloredPart);
            _local_2.setRGB(__bagColor);
            _local_2 = null;
            __colored = true;
        }
        function colorize() {
            __colored = true;
            __colorIndex = Math.ceil(Math.random() * 11);
            if (Math.random() <= 0.7) {
                var _local_2 = Math.floor(Math.random() * __gc.targetColor.length);
                __bagColor = __gc.targetColor[_local_2];
            } else {
                var _local_3 = Math.floor(Math.random() * __gc.nonTargetColorDisplayList.length);
                __bagColor = __gc.nonTargetColorDisplayList[_local_3];
            }
            color = (__bagColor);
        }
        function updateColor(mc) {
            if (__colored) {
                coloredPart = mc.colored_part;
                setColor(__bagColor);
            }
        }
        function set GameEngine(gc) {
            __gc = gc;
            //return(__get__GameEngine());
        }
        function get bagColor() {
            return(__bagColor);
        }
    }
