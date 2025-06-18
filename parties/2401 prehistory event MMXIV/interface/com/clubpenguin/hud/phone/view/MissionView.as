//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.MissionView extends com.clubpenguin.hud.phone.view.AppView
    {
        var localizedAssets, title, pending, goThereText, _visible;
        function MissionView () {
            super();
            localizedAssets = [title, pending, goThereText];
        }
        function open() {
            _visible = true;
        }
        function close() {
            _visible = false;
        }
    }
