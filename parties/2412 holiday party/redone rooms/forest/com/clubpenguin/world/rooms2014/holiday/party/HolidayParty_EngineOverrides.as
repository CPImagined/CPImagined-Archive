//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.party.HolidayParty_EngineOverrides
    {
        var defaultStartMouse;
        function HolidayParty_EngineOverrides () {
        }
        function init() {
            defaultStartMouse = _global.getCurrentEngine().defaultStartMouse;
        }
        function startMouse() {
            com.clubpenguin.util.Log.debug("HolidayParty_EngineOverrides startMouse()");
            var _this = this;
            _this.is_mouse_active = true;
            _this.onMouseMove = function () {
                if (_this.getPlayerAction() == "wait") {
                    var room_mc = _this.getRoomMovieClip();
                    var d = _this.getPlayerDirectionToMouse();
                    if (room_mc.invertedPenguins) {
                        d = d + 4;
                        if (d > 8) {
                            var invertedFrame = (d - 8);
                            d = invertedFrame;
                        }
                    }
                    if (d != _this.current_direction_to_mouse) {
                        _this.current_direction_to_mouse = d;
                        var room = com.clubpenguin.world.rooms.BaseRoom.current;
                        if (_this.SHELL.getRoomObject().room_id != _global.getCurrentParty().HolidayParty.CONSTANTS.SOLO_ROOM_ID) {
                            _this.updatePlayerFrame(_this.SHELL.getMyPlayerId(), d);
                        }
                    }
                }
            };
            _this.mouse_mc.useHandCursor = false;
            _this.mouse_mc.tabEnabled = false;
            _this.mouse_mc.onRelease = _this.clickMouse;
        }
        static var CLASS_NAME = "HolidayParty_EngineOverrides";
    }
