//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.AppMenuView extends MovieClip
    {
        var localizedAssets, txtGear, txtMission, txtTeleport, txtMessages, txtGadgets, txtMenuPuffle, _visible;
        function AppMenuView () {
            super();
            localizedAssets = [txtGear, txtMission, txtTeleport, txtMessages, txtGadgets, txtMenuPuffle];
        }
        function open() {
            var _local_3 = 0;
            while (_local_3 < localizedAssets.length) {
                MovieClip(localizedAssets[_local_3]).gotoAndStop(_global.getCurrentShell().getLocalizedFrame());
                _local_3++;
            }
            _visible = true;
        }
        function close() {
            _visible = false;
        }
        static var LINKAGE_ID = "com.clubpenguin.hud.phone.AppMenuView";
    }
