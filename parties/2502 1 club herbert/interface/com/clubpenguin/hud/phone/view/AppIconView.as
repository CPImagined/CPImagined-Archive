//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.AppIconView extends MovieClip
    {
        var startingAlpha, _alpha, rollOverSignal, rollOutSignal, pressSignal, _active;
        function AppIconView () {
            super();
            startingAlpha = _alpha;
            rollOverSignal = new org.osflash.signals.Signal(com.clubpenguin.hud.phone.view.AppIconView);
            rollOutSignal = new org.osflash.signals.Signal(com.clubpenguin.hud.phone.view.AppIconView);
            pressSignal = new org.osflash.signals.Signal(com.clubpenguin.hud.phone.view.AppIconView);
            active = (true);
        }
        function get active() {
            return(_active);
        }
        function set active(isactive) {
            if (!isactive) {
                this.onRollOut();
                _alpha = DISABLED_ALPHA;
            } else {
                _alpha = startingAlpha;
            }
            _active = isactive;
            //return(active);
        }
        function onRollOver() {
            if (active) {
                _alpha = 100;
            }
            rollOverSignal.dispatch(this);
        }
        function onRollOut() {
            if (active) {
                _alpha = startingAlpha;
            }
            rollOutSignal.dispatch(this);
        }
        function onPress() {
            if (!_active) {
                return(undefined);
            }
            _alpha = startingAlpha;
            pressSignal.dispatch(this);
        }
        static var DISABLED_ALPHA = 20;
        var title = "";
    }
