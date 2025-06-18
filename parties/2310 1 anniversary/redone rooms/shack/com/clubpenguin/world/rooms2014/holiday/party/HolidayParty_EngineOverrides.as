//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.party.HolidayParty_EngineOverrides
    {
        var defaultStartMouse;
        function HolidayParty_EngineOverrides () {
            trace("HolidayParty_EngineOverrides");
        }
        function init() {
            trace("HolidayParty_EngineOverrides init()");
            defaultStartMouse = _global.getCurrentEngine().defaultStartMouse;
        }
        function startMouse() {
            com.clubpenguin.util.Log.debug("HolidayParty_EngineOverrides startMouse()");
            trace("HolidayParty_EngineOverrides startMouse()");
            var _this = this;
            _this.is_mouse_active = true;
            _this.onMouseMove = function () {
                if (_this.getPlayerAction() == "wait") {
                    var _local_4 = _this.getRoomMovieClip();
                    var _local_2 = _this.getPlayerDirectionToMouse();
                    if (_local_4.invertedPenguins) {
                        _local_2 = _local_2 + 4;
                        if (_local_2 > 8) {
                            var _local_3 = _local_2 - 8;
                            _local_2 = _local_3;
                        }
                    }
                    if (_local_2 != _this.current_direction_to_mouse) {
                        _this.current_direction_to_mouse = _local_2;
                        var _local_5 = com.clubpenguin.world.rooms.BaseRoom.current;
                        if (_this.SHELL.getRoomObject().room_id != _global.getCurrentParty().HolidayParty.CONSTANTS.SOLO_ROOM_ID) {
                            _this.updatePlayerFrame(_this.SHELL.getMyPlayerId(), _local_2);
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
