class com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
    var _jsonObject, __get__msgViewedArray;
    function MusicPartyCookieVO(cookieId)
    {
        super(cookieId);
        trace ("PartyCookieVO()");
    } // End of the function
    function getCookieHandlerName()
    {
        return (com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO.MUSIC_COOKIE_HANDLER_NAME);
    } // End of the function
    function getSendCommandName()
    {
        return ("ERROR-NO-COOKIE-SEND-COMMAND");
    } // End of the function
    function getReceiveCommandName()
    {
        return (com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO.MUSIC_RECEIVE_COMMAND_NAME);
    } // End of the function
    function get msgViewedArray()
    {
        if (_jsonObject.msgViewedArray == undefined)
        {
            return ([0, 0, 0]);
        } // end if
        return (_jsonObject.msgViewedArray);
    } // End of the function
    function setMessageViewed(messageIndex)
    {
        var _loc2 = _global.getCurrentAirtower();
        _loc2.send(_loc2.PLAY_EXT, com.clubpenguin.world.rooms2014.music.vo.MusicPartyCookieVO.MUSIC_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.music.party.MusicPartyConstants.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function traceSetError(propertyName, value)
    {
        trace ("MusicPartyCookieVO - ERROR - " + value + " is not a valid value for " + propertyName);
    } // End of the function
    static var MUSIC_COOKIE_HANDLER_NAME = "musicparty";
    static var MUSIC_RECEIVE_COMMAND_NAME = "partycookie";
} // End of Class
