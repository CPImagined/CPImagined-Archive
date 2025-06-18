dynamic class com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
    static var FROZEN_COOKIE_HANDLER_NAME: String = "frozen";
    static var FROZEN_RECEIVE_COMMAND_NAME: String = "partycookie";
    static var NUM_FLAKES: Number = 21;
    static var ROOM_ID_BEACH: Number = 400;
    static var ROOM_ID_DOCK: Number = 800;
    static var ROOM_ID_TOWN: Number = 100;
    static var ROOM_ID_FORTS: Number = 801;
    static var ROOM_ID_PLAZA: Number = 300;
    static var ROOM_ID_FOREST: Number = 809;
    static var ROOM_ID_COVE: Number = 810;
    var _jsonObject;

    function FrozenPartyCookieVO(cookieId)
    {
        super(cookieId);
    }

    function getCookieHandlerName()
    {
        return com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME;
    }

    function getSendCommandName()
    {
        return "ERROR-NO-COOKIE-SEND-COMMAND";
    }

    function getReceiveCommandName()
    {
        return com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_RECEIVE_COMMAND_NAME;
    }

    function get msgViewedArray()
    {
        if (this._jsonObject.msgViewedArray == undefined) 
        {
            return [0, 0];
        }
        return this._jsonObject.msgViewedArray;
    }

    function setMessageViewed(messageIndex)
    {
        var __reg2 = _global.getCurrentAirtower();
        __reg2.send(__reg2.PLAY_EXT, com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.FROZEN_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.frozen.party.FrozenPartyConstants.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
    }

    function get snowflakes()
    {
        return this._jsonObject.snowflakes;
    }

    function getSnowflakesForRoom(roomId)
    {
        var __reg2 = this.getSnowflakesStartIndexForRoom(roomId);
        var __reg3 = __reg2 + 3;
        return this.__get__snowflakes().slice(__reg2, __reg3);
    }

    function getSnowflakesStartIndexForRoom(roomId)
    {
        var __reg0;
        var __reg1 = parseInt(roomId.toString());
        if ((__reg0 = __reg1) === com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_BEACH) 
        {
            return 0;
        }
        else if (__reg0 === com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_DOCK) 
        {
            return 3;
        }
        else if (__reg0 === com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_TOWN) 
        {
            return 6;
        }
        else if (__reg0 === com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_FORTS) 
        {
            return 9;
        }
        else if (__reg0 === com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_PLAZA) 
        {
            return 12;
        }
        else if (__reg0 === com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_FOREST) 
        {
            return 15;
        }
        else if (__reg0 === com.clubpenguin.world.rooms2014.frozen.vo.FrozenPartyCookieVO.ROOM_ID_COVE) 
        {
            return 18;
        }
        return -1;
    }

    function get freezingPowers()
    {
        if (this._jsonObject.freezingPowers == undefined) 
        {
            return 0;
        }
        return this._jsonObject.freezingPowers;
    }

    function traceSetError(propertyName, value)
    {
    }

}
