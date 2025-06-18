//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.BackIntoTruckBag extends com.clubpenguin.games.beancounters.FlyingBag
    {
        var _visible, animationClip, bag, coloredPart;
        function BackIntoTruckBag () {
            super();
            _visible = false;
            animationClip = bag.bag_mc;
            animationClip.gotoAndStop(1);
            coloredPart = animationClip.colored_part;
            bag.gotoAndStop(1);
        }
        function startAnimation() {
            bag.gotoAndPlay(2);
            animationClip.gotoAndPlay(1);
            _visible = true;
        }
        function onLastFrame(target) {
            bag.stop();
            animationClip.stop();
            _visible = false;
        }
    }
