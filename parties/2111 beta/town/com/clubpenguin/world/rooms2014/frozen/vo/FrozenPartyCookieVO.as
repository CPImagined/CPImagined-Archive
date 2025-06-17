class com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
    var _jsonObject, __get__snowflakes, __get__freezingPowers, __get__msgViewedArray;
    function FrozenPartyCookieVO(cookieId)
    {
        super(cookieId);
    } // End of the function
    function getCookieHandlerName()
    {
        return (com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME);
    } // End of the function
    function getSendCommandName()
    {
        return ("ERROR-NO-COOKIE-SEND-COMMAND");
    } // End of the function
    function getReceiveCommandName()
    {
        return (com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_RECEIVE_COMMAND_NAME);
    } // End of the function
    function get msgViewedArray()
    {
        if (_jsonObject.msgViewedArray == undefined)
        {
            return ([0, 0]);
        } // end if
        return (_jsonObject.msgViewedArray);
    } // End of the function
    function setMessageViewed(messageIndex)
    {
        var _loc2 = _global.getCurrentAirtower();
        _loc2.send(_loc2.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenPartyConstants.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function get snowflakes()
    {
        return (_jsonObject.snowflakes);
    } // End of the function
    function getSnowflakesForRoom(roomId)
    {
        var _loc2 = this.getSnowflakesStartIndexForRoom(roomId);
        var _loc3 = _loc2 + 3;
        //return (this.snowflakes().slice(_loc2, _loc3));
    } // End of the function
    function getSnowflakesStartIndexForRoom(roomId)
    {
        var _loc1 = parseInt(roomId.toString());
        switch (_loc1)
        {
            case com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_BEACH:
            {
                return (0);
            } 
            case com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_DOCK:
            {
                return (3);
            } 
            case com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_TOWN:
            {
                return (6);
            } 
            case com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_FORTS:
            {
                return (9);
            } 
            case com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_PLAZA:
            {
                return (12);
            } 
            case com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_FOREST:
            {
                return (15);
            } 
            case com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_COVE:
            {
                return (18);
            } 
        } // End of switch
        return (-1);
    } // End of the function
    function get freezingPowers()
    {
        if (_jsonObject.freezingPowers == undefined)
        {
            return (0);
        } // end if
        return (_jsonObject.freezingPowers);
    } // End of the function
    function traceSetError(propertyName, value)
    {
    } // End of the function
    static var FROZEN_COOKIE_HANDLER_NAME = "frozen";
    static var FROZEN_RECEIVE_COMMAND_NAME = "partycookie";
    static var NUM_FLAKES = 21;
    static var ROOM_ID_BEACH = 400;
    static var ROOM_ID_DOCK = 800;
    static var ROOM_ID_TOWN = 100;
    static var ROOM_ID_FORTS = 801;
    static var ROOM_ID_PLAZA = 300;
    static var ROOM_ID_FOREST = 809;
    static var ROOM_ID_COVE = 810;
} // End of Class
