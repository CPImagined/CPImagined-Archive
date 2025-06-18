//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.mock.Mock
    {
        static var service, flakes, tower;
        function Mock () {
        }
        static function get initialized() {
            return(_initialized);
        }
        static function mockResponse(target, method, returnValue) {
            target[method] = function () {
                return(returnValue);
            };
        }
        static function destroy() {
        }
        static function init() {
            if (_global.getCurrentShell()) {
                return(undefined);
            }
            _initialized = true;
            mockShell.getCurrentServerRoomId = (mockShell.getCurrentRoomId = function () {
                return(400);
            });
            service = new com.clubpenguin.services.ServerCookieService();
            mockShell.getServerCookieService = function () {
                return(com.clubpenguin.mock.Mock.service);
            };
            _global.getCurrentShell = function () {
                return(com.clubpenguin.mock.Mock.mockShell);
            };
            flakes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            tower = new com.clubpenguin.net.Airtower(mockShell);
            tower.send = function (extension, command, arr, type, room_id) {
                com.clubpenguin.mock.Mock.flakes[arr[0]] = 1;
                com.clubpenguin.mock.Mock.tower.updateListeners("partycookie", [0, ("{\"msgViewedArray\" : [ 0, 0 ],\"snowflakes\" : [" + com.clubpenguin.mock.Mock.flakes) + "],\"freezingPowers\": 0}"]);
            };
            _global.getCurrentAirtower = function () {
                return(com.clubpenguin.mock.Mock.tower);
            };
            com.clubpenguin.party.BaseParty.CONSTANTS = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartyConstants;
            com.clubpenguin.party.BaseParty.init(new com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO("123"));
            com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.init();
            com.clubpenguin.party.BaseParty.CURRENT_PARTY = com.clubpenguin.world.rooms2014.frozen.party.FrozenParty;
            _level0.onEnterFrame = function () {
                if (_level0.startRoom) {
                    _level0.startRoom();
                    _level0.onEnterFrame = undefined;
                }
            };
        }
        static var mockShell = {};
        static var _initialized = false;
        static var SHELL = mockShell;
    }
