//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.common.MovieClipButton extends MovieClip
    {
        var gotoAndStop, enabled, onRollOver, onRollOut, onPress, onMouseUp;
        function MovieClipButton () {
            super();
            this.gotoAndStop(1);
            enabled = true;
            onRollOver = com.clubpenguin.util.Delegate.create(this, rollOverState);
            onRollOut = com.clubpenguin.util.Delegate.create(this, rollOutState);
            onPress = com.clubpenguin.util.Delegate.create(this, hitState);
            onMouseUp = com.clubpenguin.util.Delegate.create(this, rollOutState);
        }
        function rollOverState() {
            this.gotoAndStop(2);
        }
        function rollOutState() {
            this.gotoAndStop(1);
        }
        function hitState() {
            this.gotoAndStop(3);
        }
    }
