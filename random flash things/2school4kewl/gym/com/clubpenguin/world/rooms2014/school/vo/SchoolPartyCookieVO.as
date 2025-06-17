class com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
    var serialize, _jsonObject, __get__msgViewedArray, __get__snowflakes;
    function SchoolPartyCookieVO(cookieId)
    {
        super(cookieId);
        trace ("SchoolPartyCookieVO()");
    } // End of the function
    function getCookieHandlerName()
    {
        return (com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME);
    } // End of the function
    function getSendCommandName()
    {
        return ("ERROR-NO-COOKIE-SEND-COMMAND");
    } // End of the function
    function getReceiveCommandName()
    {
        return (com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_RECEIVE_COMMAND_NAME);
    } // End of the function
    function get msgViewedArray()
    {
        trace ("SchoolPartyCookieVO.msgViewedArray: " + this.serialize());
        if (_jsonObject.msgViewedArray == undefined)
        {
            return ([0, 0]);
        } // end if
        return (_jsonObject.msgViewedArray);
    } // End of the function
    function setMessageViewed(messageIndex)
    {
        var _loc2 = _global.getCurrentAirtower();
        _loc2.send(_loc2.PLAY_EXT, com.clubpenguin.world.rooms2014.school.vo.SchoolPartyCookieVO.SCHOOL_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2014.school.SchoolPartyConstants.MESSAGE_VIEWED_COMMAND, [messageIndex], "str", _global.getCurrentShell().getCurrentServerRoomId());
    } // End of the function
    function get snowflakes()
    {
        trace ("SchoolPartyCookieVO.snowflakes _jsonObject.questItems: " + _jsonObject.questTaskStatus);
        trace ("SchoolPartyCookieVO.snowflakes _jsonObjects: " + _jsonObject);
        for (var _loc3 in _jsonObject)
        {
            var _loc2 = _jsonObject[_loc3];
            trace ("SchoolPartyCookieVO json property : " + _loc3 + " = " + _loc2);
        } // end of for...in
        if (_jsonObject.questTaskStatus == undefined)
        {
            return ([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        } // end if
        return (_jsonObject.questTaskStatus);
    } // End of the function
    function traceSetError(propertyName, value)
    {
        trace ("FrozenPartyCookieVO - ERROR - " + value + " is not a valid value for " + propertyName);
    } // End of the function
    function areItemsCollected()
    {
        for (var _loc2 = 0; _loc2 < _jsonObject.questTaskStatus.length; ++_loc2)
        {
            if (_jsonObject.questTaskStatus[_loc2] == 0)
            {
                return (false);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    static var SCHOOL_COOKIE_HANDLER_NAME = "school";
    static var SCHOOL_RECEIVE_COMMAND_NAME = "partycookie";
} // End of Class
