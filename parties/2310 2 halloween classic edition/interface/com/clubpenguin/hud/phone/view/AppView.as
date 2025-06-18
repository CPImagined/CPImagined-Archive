//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.AppView extends MovieClip
    {
        var closed, closeButton, _visible;
        function AppView () {
            super();
            closed = new org.osflash.signals.Signal();
            closeButton["button"].onRelease = com.clubpenguin.util.Delegate.create(closed, closed.dispatch);
        }
        function open() {
            _visible = true;
        }
        function close() {
            _visible = false;
        }
    }
