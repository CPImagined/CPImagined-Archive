//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.FieldOpsView extends com.clubpenguin.hud.phone.view.AppView
    {
        var localizedAssets, titleText, goThereText, done, pending, _visible;
        function FieldOpsView () {
            super();
            localizedAssets = [titleText, goThereText, done, pending];
        }
        function open() {
            _visible = true;
        }
        function close() {
            _visible = false;
        }
    }
