//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.RecruitView extends com.clubpenguin.hud.phone.view.AppView
    {
        var localizedAssets, title, recruitInstructions, _visible;
        function RecruitView () {
            super();
            localizedAssets = [title, recruitInstructions];
        }
        function open() {
            _visible = true;
        }
        function close() {
            _visible = false;
        }
    }
