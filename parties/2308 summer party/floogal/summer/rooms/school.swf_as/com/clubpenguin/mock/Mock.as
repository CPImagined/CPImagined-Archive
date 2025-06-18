dynamic class com.clubpenguin.mock.Mock
{
    static var mockShell = {};
    static var _initialized: Boolean = false;
    static var SHELL = com.clubpenguin.mock.Mock.mockShell;

    function Mock()
    {
    }

    static function get initialized()
    {
        return com.clubpenguin.mock.Mock._initialized;
    }

    static function mockResponse(target, method, returnValue)
    {
        target[method] = function ()
        {
            return returnValue;
        }
        ;
    }

    static function destroy()
    {
    }

    static function init()
    {
        if (_global.getCurrentShell()) 
        {
            return undefined;
        }
        com.clubpenguin.mock.Mock._initialized = true;
        com.clubpenguin.mock.Mock.mockShell.getCurrentServerRoomId = com.clubpenguin.mock.Mock.mockShell.getCurrentRoomId = function ()
        {
            return 400;
        }
        ;
        com.clubpenguin.mock.Mock.service = new com.clubpenguin.services.ServerCookieService();
        com.clubpenguin.mock.Mock.mockShell.getServerCookieService = function ()
        {
            return com.clubpenguin.mock.Mock.service;
        }
        ;
        _global.getCurrentShell = function ()
        {
            return com.clubpenguin.mock.Mock.mockShell;
        }
        ;
        com.clubpenguin.mock.Mock.flakes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        com.clubpenguin.mock.Mock.tower = new com.clubpenguin.net.Airtower(com.clubpenguin.mock.Mock.mockShell);
        com.clubpenguin.mock.Mock.tower.send = function (extension, command, arr, type, room_id)
        {
            com.clubpenguin.mock.Mock.flakes[arr[0]] = 1;
            com.clubpenguin.mock.Mock.tower.updateListeners("partycookie", [0, "{\"msgViewedArray\" : [ 0, 0 ],\"snowflakes\" : [" + com.clubpenguin.mock.Mock.flakes + "],\"freezingPowers\": 0}"]);
        }
        ;
        _global.getCurrentAirtower = function ()
        {
            return com.clubpenguin.mock.Mock.tower;
        }
        ;
        com.clubpenguin.party.BaseParty.CONSTANTS = com.clubpenguin.world.rooms2014.frozen.party.FrozenPartyConstants;
        com.clubpenguin.party.BaseParty.init(new com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO("123"));
        com.clubpenguin.world.rooms2014.frozen.party.FrozenParty.init();
        com.clubpenguin.party.BaseParty.__set__CURRENT_PARTY(com.clubpenguin.world.rooms2014.frozen.party.FrozenParty);
        _level0.onEnterFrame = function ()
        {
            if (_level0.startRoom) 
            {
                _level0.startRoom();
                _level0.onEnterFrame = undefined;
            }
        }
        ;
    }

}
