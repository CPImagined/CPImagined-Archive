//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.TeleportView extends com.clubpenguin.hud.phone.view.AppView
    {
        var localizedAssets, title, teleportingTo, cancelTeleport, roomList, teleportSwirl, destination, cancelTeleportButton, _visible;
        function TeleportView () {
            super();
            localizedAssets = [title, teleportingTo, cancelTeleport];
        }
        function reset() {
            roomList._visible = true;
            teleportSwirl._visible = false;
            teleportingTo._visible = false;
            destination._visible = false;
            cancelTeleport._visible = false;
            cancelTeleportButton._visible = false;
        }
        function showTeleportCountDown() {
            roomList._visible = false;
            teleportSwirl._visible = true;
            teleportingTo._visible = true;
            destination._visible = true;
            cancelTeleport._visible = true;
            cancelTeleportButton._visible = true;
        }
        function open() {
            reset();
            teleportSwirl.swirlAnimation.gotoAndPlay(2);
            _visible = true;
        }
        function close() {
            teleportSwirl.swirlAnimation.gotoAndStop(1);
            _visible = false;
        }
    }
