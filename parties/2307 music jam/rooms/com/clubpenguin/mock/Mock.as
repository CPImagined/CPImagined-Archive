class com.clubpenguin.mock.Mock
{
    static var service, flakes, tower, __get__initialized;
    function Mock()
    {
    } // End of the function
    static function get initialized()
    {
        return (com.clubpenguin.mock.Mock._initialized);
    } // End of the function
    static function mockResponse(target, method, returnValue)
    {
        target[method] = function ()
        {
            return (returnValue);
        };
    } // End of the function
    static function destroy()
    {
    } // End of the function
    static function init()
    {
        if (_global.getCurrentShell())
        {
            return;
        } // end if
        _initialized = true;
        com.clubpenguin.mock.Mock.mockShell.getCurrentServerRoomId = com.clubpenguin.mock.Mock.mockShell.getCurrentRoomId = function ()
        {
            return (400);
        };
        service = new com.clubpenguin.services.ServerCookieService();
        com.clubpenguin.mock.Mock.mockShell.getServerCookieService = function ()
        {
            return (com.clubpenguin.mock.Mock.service);
        };
        _global.getCurrentShell = function ()
        {
            return (com.clubpenguin.mock.Mock.mockShell);
        };
        flakes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        tower = new com.clubpenguin.net.Airtower(com.clubpenguin.mock.Mock.mockShell);
        com.clubpenguin.mock.Mock.tower.send = function (extension, command, arr, type, room_id)
        {
            com.clubpenguin.mock.Mock.flakes[arr[0]] = 1;
            com.clubpenguin.mock.Mock.tower.updateListeners("partycookie", [0, "{\"msgViewedArray\" : [ 0, 0 ],\"snowflakes\" : [" + com.clubpenguin.mock.Mock.flakes + "],\"freezingPowers\": 0}"]);
        };
        _global.getCurrentAirtower = function ()
        {
            return (com.clubpenguin.mock.Mock.tower);
        };
        _level0.onEnterFrame = function ()
        {
            if (_level0.startRoom)
            {
                _level0.startRoom();
                _level0.onEnterFrame = undefined;
            } // end if
        };
    } // End of the function
    static var mockShell = {};
    static var _initialized = false;
    static var SHELL = com.clubpenguin.mock.Mock.mockShell;
} // End of Class
