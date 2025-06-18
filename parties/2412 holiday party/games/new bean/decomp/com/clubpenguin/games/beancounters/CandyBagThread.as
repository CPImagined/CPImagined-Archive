//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.beancounters.CandyBagThread extends MovieClip
    {
        var _parent, _x, _y, onPress, onRelease, __initX, __initY, _visible;
        function CandyBagThread () {
            super();
            _parent.createEmptyMovieClip("candyBagThreadMc", _parent.getNextHighestDepth());
            _parent.candyBagThreadMc.lineStyle(2);
            _parent.candyBagThreadMc.moveTo(_x, _y);
            onPress = com.clubpenguin.util.Delegate.create(this, press1);
            onRelease = com.clubpenguin.util.Delegate.create(this, release1);
        }
        function press1() {
            __isHeld = true;
            __initX = _x;
            __initY = _y;
            _parent.candyBagAnim.play();
            _visible = false;
        }
        function release1() {
            __isHeld = false;
        }
        var __isHeld = false;
    }
