//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.party.HolidayParty_InterfaceOverrides
    {
        var defaultDoCrossHairRelease;
        function HolidayParty_InterfaceOverrides () {
        }
        function init() {
            defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
        }
        function doCrossHairRelease() {
            var _this = this;
            var x = Math.round((_this.CROSSHAIR._x + random(20)) - 10);
            var y = Math.round((_this.CROSSHAIR._y + random(20)) - 10);
            _this.sendThrowBall(x, y);
            _this.stopDrag();
            _this.CROSSHAIR._y = -100;
            _this.CROSSHAIR._visible = false;
            Selection.setFocus(null);
            com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds.playSnowballThrow();
        }
    }
