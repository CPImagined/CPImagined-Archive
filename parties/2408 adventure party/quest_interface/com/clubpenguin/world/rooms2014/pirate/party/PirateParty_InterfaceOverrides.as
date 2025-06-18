//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.party.PirateParty_InterfaceOverrides
    {
        function PirateParty_InterfaceOverrides () {
            trace("PirateParty_InterfaceOverrides");
        }
        function showCrosshair() {
            var _local_3 = this;
            if (_local_3.SHELL.getCurrentRoomId() == _global.getCurrentParty().PirateParty.CONSTANTS.CRAB_BATTLE_ROOM_ID) {
                return(undefined);
            }
            _local_3.CROSSHAIR._visible = true;
            _local_3.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
            _local_3.CROSSHAIR._x = _local_3._xmouse;
            _local_3.CROSSHAIR._y = _local_3._ymouse;
            _local_3.CROSSHAIR.target_btn.onRelease = mx.utils.Delegate.create(this, _local_3.doCrossHairRelease);
            _local_3.snowballCrosshairShown.dispatch();
        }
        static var CLASS_NAME = "PirateParty_InterfaceOverrides";
    }
