//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.party.HolidayParty_InterfaceOverrides
    {
        var defaultDoCrossHairRelease;
        function HolidayParty_InterfaceOverrides () {
        }
        function init() {
            trace("HolidayParty_InterfaceOverrides init()");
            defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
        }
        function doCrossHairRelease() {
            var _local_2 = this;
            var _local_4 = Math.round((_local_2.CROSSHAIR._x + random(20)) - 10);
            var _local_3 = Math.round((_local_2.CROSSHAIR._y + random(20)) - 10);
            _local_2.sendThrowBall(_local_4, _local_3);
            _local_2.stopDrag();
            _local_2.CROSSHAIR._y = -100;
            _local_2.CROSSHAIR._visible = false;
            Selection.setFocus(null);
            com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds.playSnowballThrow();
        }
    }
