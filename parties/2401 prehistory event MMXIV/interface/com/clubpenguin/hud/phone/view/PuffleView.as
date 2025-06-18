//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.PuffleView extends com.clubpenguin.hud.phone.view.AppView
    {
        var localizedAssets, title, flareTitle, _visible;
        function PuffleView () {
            super();
            localizedAssets = [title, flareTitle];
        }
        function open() {
            _visible = true;
        }
        function close() {
            _visible = false;
        }
    }
